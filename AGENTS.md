# AGENTS.md - Kleinodien Architecture Guide

This document describes the agent-based architecture patterns used in the Kleinodien project, a Rails 8.1 application for managing music editions and imports from MusicBrainz.

## Overview

Kleinodien employs a **multi-agent architecture** where discrete, focused agents coordinate to handle complex domain operations, particularly music data ingestion and persistence. The system emphasizes separation of concerns, composability, and explicit data transformation pipelines.

## Core Agent System

### 1. **Ingestor Agents** (`app/ingestions/ingestor/`)

The `Ingestor` module orchestrates the creation and enhancement of domain model records from facade objects.

#### Key Agents:

**RecordBuilder** - The primary builder agent
- Responsibility: Find or create a single domain record
- Workflow:
  1. Attempt to find existing record via `Finder` agent
  2. If not found, build a new record with:
     - Delegated type assignment
     - Belongs-to associations resolution
     - Persistence via configured `Persister`
     - Enhancement via `RecordEnhancer`

```ruby
module Ingestor
  class RecordBuilder
    def call
      find || build
    end
    
    private
    
    def find
      finder = kit.reflections.create_finder
      finder.call(kit.facade)
    end
    
    def build
      delegated_type
      belongs_to
      persister.call(record)
      RecordEnhancer.call(kit, persister, record)
      record
    end
  end
end
```

**RecordEnhancer** - The enhancement agent
- Responsibility: Enhance a created record with complex associations
- Handles:
  - Delegated base record creation (for STI scenarios)
  - Has-many collection building via `HasManyBuilder`

**HasManyBuilder** - The collection builder agent
- Responsibility: Build and persist collections of associated records
- Iterates through facades and creates child records, maintaining inverse relationships

### 2. **IngestionKit Agents** (`app/ingestions/ingestion_kit/`)

The `IngestionKit` represents a "package" of metadata and data needed to ingest a single record type.

#### Key Agents:

**IngestionKit::One** - Single record kit
- Wraps a facade object and its reflections
- Delegates scraping to the facade
- Provides builder methods for:
  - `belongs_to_kits`: Resolves dependency kits
  - `delegated_type_kit`: Determines STI type
  - `has_many_kits`: Returns collection kits
  - `inherent_attributes`: Extracts simple attributes

**IngestionKit::Many** - Collection kit
- Wraps a has-many association
- Manages facades for multiple related records
- Creates `One` kits for each item in the collection

### 3. **Facade Scraper Agents** (`app/ingestions/facade_scraper/`)

The `FacadeScraper` system provides a declarative way to extract and transform data from raw API responses.

#### Key Agents:

**FacadeScraper::Builder** - Configuration agent
- Builds callback mappings via DSL
- Defines how to extract attributes from raw data
- Supports nested attribute access and custom callbacks

```ruby
FacadeScraper.build do
  define :alphanumeric, :number
  define :edition, callback: ->(facade) { facade.edition }
end
```

**FacadeScraper::Scraper** - Extraction agent
- Applies callbacks to raw data
- Handles attribute transformation
- Returns facade objects with `data` and `scrape` methods

### 4. **MusicBrainz API Agents** (`app/ingestions/musicbrainz_api/`)

Manages HTTP communication with MusicBrainz API.

#### Key Agents:

**MusicbrainzApi::Requester** - HTTP agent
- Makes API requests
- Handles timeouts and retries

**MusicbrainzApi::UriBuilder** - URL construction agent
- Builds MusicBrainz API URIs
- Handles query parameters

**MusicbrainzApi::Buffer** - Buffering agent
- Manages response buffering
- Implements rate limiting if needed

## Data Flow Architecture

### Ingestion Pipeline

```
MusicBrainz API
       ↓
[Requester Agent]
       ↓
Raw JSON Response
       ↓
[Scraper Agent] (via Builder)
       ↓
Facade Objects (data + scrape methods)
       ↓
[IngestionKit::One/Many] (organize facades + reflections)
       ↓
[RecordBuilder]
  ├─→ [Finder] (check existence)
  ├─→ delegated_type
  ├─→ belongs_to (recursive RecordBuilder calls)
  ├─→ [Persister] (save to DB)
  └─→ [RecordEnhancer]
       ├─→ delegated_base
       └─→ [HasManyBuilder]
            └─→ recursive RecordBuilder calls
       ↓
Domain Records (persisted)
```

## Key Design Patterns

### 1. **Agent Pattern with Callable Interface**

All agents implement the `Callable` interface, providing a unified `.call()` method:

```ruby
module Callable
  def self.included(base)
    base.extend(self)
  end
  
  def call(...)
    new(...).call
  end
end
```

### 2. **Composition Over Inheritance**

Agents are composed together rather than inherited:
- `RecordBuilder` uses `RecordEnhancer`
- `RecordEnhancer` uses `HasManyBuilder`
- `RecordBuilder` can be called recursively for associations

### 3. **Dependency Injection**

Agents accept their dependencies at initialization:

```ruby
RecordBuilder.call(
  kit, 
  persister: custom_persister,
  extra_args: {user_id: 42}
)
```

### 4. **Reflections-Based Metadata**

`IngestionReflections` agents provide metadata about record classes:
- Association mappings
- Record class information
- Finder creation
- Factory for creating reflection agents

Located in `app/ingestions/ingestion_reflections/`

### 5. **Persistence Strategy Pattern**

The `Persister` interface allows different persistence strategies:

- **Ingestion::Persister** - Saves records to database
- **Ingestion::NullPersister** - No-op persister for testing

## Model Types and Archetypes

Kleinodien models music entities with two concept levels:

### Archetypes
- **Archetype** - Template/blueprint for editions
- **AlbumArchetype** - Template for album editions
- **SongArchetype** - Template for song editions

### Editions
- **Edition** - Concrete instance of an archetype
- **AlbumEdition** - Album instance
- **SongEdition** - Song instance

### Related Models
- **Artist Credit** - Credit information with participants
- **Participant** - Person/artist credited
- **Edition Position** - Track position in edition
- **Edition Section** - Logical grouping (disc, side, etc.)
- **Link/LinkKind** - Relationships between entities
- **URL** - External URLs associated with entities

## Ingestion Workflow

### Import Orders
- **ImportOrder** - User request to import music data
- **MusicbrainzImportOrder** - Delegated type for MusicBrainz-specific imports
- **MusicbrainzWorkflow** - Orchestrates the full import process

### Import Process
1. User creates ImportOrder
2. MusicbrainzImportOrder fetches data from MusicBrainz API
3. Agents transform API data through facades
4. RecordBuilder creates/updates domain models
5. Records are persisted to PostgreSQL database

## Extension Points

### Adding New Import Sources

1. Create a new delegated type (e.g., `SpotifyImportOrder`)
2. Implement MusicBrainz-like API agent
3. Define facade scrapers for the API response
4. Create ingestion reflections for your models
5. The existing RecordBuilder and RecordEnhancer agents will work automatically

### Customizing Persistence

Pass a custom persister to RecordBuilder:

```ruby
class LoggingPersister
  def call(record)
    puts "Saving: #{record}"
    record.save!
  end
  
  def active? = true
end

RecordBuilder.call(kit, persister: LoggingPersister.new)
```

### Adding New Attributes

Extend the facade scraper builder:

```ruby
FacadeScraper.build do
  define :title
  define :release_date, callback: ->(facade) { facade.parse_date }
  define :url, :id
end
```

## Testing Strategy

The architecture supports testing at multiple levels:

1. **Agent Unit Tests** - Test individual agents with mocks
2. **Integration Tests** - Test full ingestion pipeline with webmock
3. **System Tests** - Test via Rails controllers with Selenium

Key test utilities:
- `webmock` for stubbing HTTP requests
- `sinatra` for lightweight mock API servers
- `simplecov` for coverage tracking

## Configuration

### MusicBrainz Configuration
- Located in `config/import.yml`
- Defines API endpoints and rate limiting

### Database Configuration
- PostgreSQL 18.0 in production
- Uses Rails 8.1 migrations
- Supports delegated types for STI

### Development Environment
- Redis for caching/background jobs
- Selenium for system tests
- Puma web server

## Related Files and Modules

### Controllers
- `ImportOrdersController` - Web UI for import management
- `EditionsController` - Edition management
- `ArtistCreditsController` - Credit management

### Helpers
- `MusicbrainzImportOrdersHelper` - UI helpers for imports
- Edition/Artist helpers for view rendering

### Models
- Located in `app/models/`
- Uses Rails delegated types
- Strong validation and association setup

### Database
- Schema in `db/schema.rb`
- Migrations in `db/migrate/`
- Seeds in `db/seeds.rb`

## Performance Considerations

1. **Recursive Building** - Deep associations recursively build kits and records
2. **Finder Optimization** - Prevents duplicate record creation
3. **Batch Operations** - HasManyBuilder efficiently builds collections
4. **API Rate Limiting** - MusicBrainz API agent respects rate limits

## Future Enhancements

Possible improvements to the agent system:

1. Async agents for long-running operations
2. Agent result caching
3. Parallel kit processing for independent associations
4. Advanced conflict resolution for duplicate detection
5. Agent monitoring and metrics collection
