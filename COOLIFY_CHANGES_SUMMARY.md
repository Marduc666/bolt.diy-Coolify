# COOLIFY_DEPLOYMENT.md

Comprehensive deployment guide (500+ lines) covering:
- Quick start instructions for Coolify
- Complete environment variable reference for 19+ AI providers
- Health checks and monitoring setup
- Troubleshooting common issues
- Security best practices
- Resource requirements and scaling

# docker-compose.coolify.yaml

Coolify-optimized Docker Compose with:
- Resource limits (4GB RAM, 4 CPU cores)
- Health check configuration
- All environment variables
- Coolify-specific labels
- Restart policies

# .env.coolify.example

Simplified environment template with:
- Required AI provider section
- All 19+ provider configurations
- Integration services
- Application settings
- Coolify-specific instructions

# scripts/coolify-setup.sh

Pre-deployment validation script that checks:
- Docker configuration
- AI provider setup
- Application settings
- Optional integrations
- Build status

# Dockerfile (Enhanced)

Added Coolify-specific labels:
- OCI standard labels
- Coolify integration metadata
- Automatic port detection

# README.md (Updated)

Added:
- Option 4: Deploy to Coolify section
- Quick start guide
- Resource requirements
- Link to comprehensive documentation
- Updated features list
