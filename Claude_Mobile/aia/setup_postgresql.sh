#!/bin/bash
################################################################################
# AIA PostgreSQL Database Setup
# Creates aia_intelligence database with required tables
################################################################################

echo "🗄️  Setting up AIA PostgreSQL Database..."
echo ""

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null; then
    echo "❌ PostgreSQL not found!"
    echo "📦 Install with: sudo apt install postgresql postgresql-contrib"
    exit 1
fi

echo "✅ PostgreSQL found"

# Database configuration
DB_NAME="aia_intelligence"
DB_USER="${USER}"

# Create database
echo "📊 Creating database: $DB_NAME"
sudo -u postgres psql -c "CREATE DATABASE $DB_NAME;" 2>/dev/null || echo "  Database already exists"

# Grant privileges
echo "🔑 Granting privileges to user: $DB_USER"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;" 2>/dev/null

# Create tables
echo "📋 Creating tables..."

psql -d $DB_NAME << 'SQL'

-- Interactions table: Complete conversation history
CREATE TABLE IF NOT EXISTS interactions (
    id SERIAL PRIMARY KEY,
    session_id VARCHAR(255) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_input TEXT,
    assistant_response TEXT,
    tools_used JSONB,
    files_modified JSONB,
    commands_executed JSONB,
    context JSONB,
    project_path TEXT,
    metadata JSONB
);

CREATE INDEX IF NOT EXISTS idx_interactions_session ON interactions(session_id);
CREATE INDEX IF NOT EXISTS idx_interactions_timestamp ON interactions(timestamp);
CREATE INDEX IF NOT EXISTS idx_interactions_project ON interactions(project_path);

-- Personality table: Learned user preferences
CREATE TABLE IF NOT EXISTS personality (
    id SERIAL PRIMARY KEY,
    category VARCHAR(100) NOT NULL,
    preference_key VARCHAR(255) NOT NULL,
    preference_value JSONB NOT NULL,
    confidence_score FLOAT DEFAULT 0.5,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    occurrence_count INTEGER DEFAULT 1,
    UNIQUE(category, preference_key)
);

CREATE INDEX IF NOT EXISTS idx_personality_category ON personality(category);

-- Projects table: Project intelligence and metadata
CREATE TABLE IF NOT EXISTS projects (
    id SERIAL PRIMARY KEY,
    project_path TEXT UNIQUE NOT NULL,
    project_name VARCHAR(255),
    tech_stack JSONB,
    architecture_notes TEXT,
    first_seen TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_accessed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    file_count INTEGER,
    language_distribution JSONB,
    dependencies JSONB,
    git_info JSONB,
    metadata JSONB
);

CREATE INDEX IF NOT EXISTS idx_projects_path ON projects(project_path);
CREATE INDEX IF NOT EXISTS idx_projects_last_accessed ON projects(last_accessed);

-- Learning patterns table: Behavioral analysis
CREATE TABLE IF NOT EXISTS learning_patterns (
    id SERIAL PRIMARY KEY,
    pattern_type VARCHAR(100) NOT NULL,
    pattern_name VARCHAR(255) NOT NULL,
    pattern_data JSONB NOT NULL,
    frequency INTEGER DEFAULT 1,
    effectiveness_score FLOAT DEFAULT 0.5,
    first_observed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_observed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tags JSONB,
    UNIQUE(pattern_type, pattern_name)
);

CREATE INDEX IF NOT EXISTS idx_learning_type ON learning_patterns(pattern_type);
CREATE INDEX IF NOT EXISTS idx_learning_effectiveness ON learning_patterns(effectiveness_score);

-- Session state table: Current session tracking
CREATE TABLE IF NOT EXISTS session_state (
    session_id VARCHAR(255) PRIMARY KEY,
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP,
    current_project TEXT,
    active_tasks JSONB,
    context_summary TEXT,
    metadata JSONB
);

-- Create views for common queries
CREATE OR REPLACE VIEW recent_interactions AS
SELECT * FROM interactions
ORDER BY timestamp DESC
LIMIT 100;

CREATE OR REPLACE VIEW top_preferences AS
SELECT category, preference_key, preference_value, confidence_score
FROM personality
WHERE confidence_score > 0.7
ORDER BY confidence_score DESC;

CREATE OR REPLACE VIEW active_projects AS
SELECT project_name, project_path, last_accessed, tech_stack
FROM projects
WHERE last_accessed > NOW() - INTERVAL '30 days'
ORDER BY last_accessed DESC;

SQL

echo ""
echo "✅ AIA PostgreSQL database setup complete!"
echo ""
echo "📊 Database: $DB_NAME"
echo "🔗 Connection: postgresql://localhost:5432/$DB_NAME"
echo ""
echo "📋 Tables created:"
echo "  • interactions        - Conversation history"
echo "  • personality         - User preferences"
echo "  • projects            - Project intelligence"
echo "  • learning_patterns   - Behavioral analysis"
echo "  • session_state       - Current session tracking"
echo ""
echo "🎯 AIA is ready to use PostgreSQL!"
