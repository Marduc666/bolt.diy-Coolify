#!/bin/bash
# Coolify Setup and Validation Script for bolt.diy
# This script helps validate your Coolify deployment configuration

set -e

echo "================================================"
echo "bolt.diy Coolify Deployment Setup"
echo "================================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a variable is set
check_var() {
    local var_name=$1
    local var_value=${!var_name}
    
    if [ -z "$var_value" ]; then
        echo -e "${RED}✗${NC} $var_name is not set"
        return 1
    else
        echo -e "${GREEN}✓${NC} $var_name is set"
        return 0
    fi
}

# Function to check if at least one AI provider is configured
check_ai_providers() {
    echo ""
    echo "Checking AI Provider Configuration..."
    echo "--------------------------------------"
    
    local providers_found=0
    
    # Check cloud providers
    if [ ! -z "$ANTHROPIC_API_KEY" ]; then
        echo -e "${GREEN}✓${NC} Anthropic API key configured"
        providers_found=$((providers_found + 1))
    fi
    
    if [ ! -z "$OPENAI_API_KEY" ]; then
        echo -e "${GREEN}✓${NC} OpenAI API key configured"
        providers_found=$((providers_found + 1))
    fi
    
    if [ ! -z "$GROQ_API_KEY" ]; then
        echo -e "${GREEN}✓${NC} Groq API key configured"
        providers_found=$((providers_found + 1))
    fi
    
    if [ ! -z "$GOOGLE_GENERATIVE_AI_API_KEY" ]; then
        echo -e "${GREEN}✓${NC} Google Gemini API key configured"
        providers_found=$((providers_found + 1))
    fi
    
    if [ ! -z "$DEEPSEEK_API_KEY" ]; then
        echo -e "${GREEN}✓${NC} DeepSeek API key configured"
        providers_found=$((providers_found + 1))
    fi
    
    if [ ! -z "$MISTRAL_API_KEY" ]; then
        echo -e "${GREEN}✓${NC} Mistral API key configured"
        providers_found=$((providers_found + 1))
    fi
    
    if [ ! -z "$COHERE_API_KEY" ]; then
        echo -e "${GREEN}✓${NC} Cohere API key configured"
        providers_found=$((providers_found + 1))
    fi
    
    if [ ! -z "$XAI_API_KEY" ]; then
        echo -e "${GREEN}✓${NC} X.AI API key configured"
        providers_found=$((providers_found + 1))
    fi
    
    if [ ! -z "$TOGETHER_API_KEY" ]; then
        echo -e "${GREEN}✓${NC} Together AI API key configured"
        providers_found=$((providers_found + 1))
    fi
    
    if [ ! -z "$OPEN_ROUTER_API_KEY" ]; then
        echo -e "${GREEN}✓${NC} OpenRouter API key configured"
        providers_found=$((providers_found + 1))
    fi
    
    # Check local providers
    if [ ! -z "$OLLAMA_API_BASE_URL" ]; then
        echo -e "${GREEN}✓${NC} Ollama configured at $OLLAMA_API_BASE_URL"
        providers_found=$((providers_found + 1))
    fi
    
    if [ ! -z "$LMSTUDIO_API_BASE_URL" ]; then
        echo -e "${GREEN}✓${NC} LM Studio configured at $LMSTUDIO_API_BASE_URL"
        providers_found=$((providers_found + 1))
    fi
    
    echo ""
    if [ $providers_found -eq 0 ]; then
        echo -e "${RED}✗ ERROR: No AI providers configured!${NC}"
        echo "  You must configure at least one AI provider."
        echo "  See COOLIFY_DEPLOYMENT.md for details."
        return 1
    else
        echo -e "${GREEN}✓ Found $providers_found AI provider(s) configured${NC}"
        return 0
    fi
}

# Function to check application settings
check_app_settings() {
    echo ""
    echo "Checking Application Settings..."
    echo "--------------------------------"
    
    # Check NODE_ENV
    if [ "$NODE_ENV" = "production" ]; then
        echo -e "${GREEN}✓${NC} NODE_ENV is set to production"
    else
        echo -e "${YELLOW}⚠${NC} NODE_ENV is not set to production (current: ${NODE_ENV:-not set})"
    fi
    
    # Check PORT
    if [ ! -z "$PORT" ]; then
        echo -e "${GREEN}✓${NC} PORT is set to $PORT"
    else
        echo -e "${YELLOW}⚠${NC} PORT not set, will use default (5173)"
    fi
    
    # Check LOG_LEVEL
    if [ ! -z "$VITE_LOG_LEVEL" ]; then
        echo -e "${GREEN}✓${NC} VITE_LOG_LEVEL is set to $VITE_LOG_LEVEL"
    else
        echo -e "${YELLOW}⚠${NC} VITE_LOG_LEVEL not set, will use default"
    fi
}

# Function to check optional integrations
check_integrations() {
    echo ""
    echo "Checking Optional Integrations..."
    echo "---------------------------------"
    
    local integrations_found=0
    
    if [ ! -z "$VITE_GITHUB_ACCESS_TOKEN" ]; then
        echo -e "${GREEN}✓${NC} GitHub integration configured"
        integrations_found=$((integrations_found + 1))
    fi
    
    if [ ! -z "$VITE_GITLAB_ACCESS_TOKEN" ]; then
        echo -e "${GREEN}✓${NC} GitLab integration configured"
        integrations_found=$((integrations_found + 1))
    fi
    
    if [ ! -z "$VITE_VERCEL_ACCESS_TOKEN" ]; then
        echo -e "${GREEN}✓${NC} Vercel integration configured"
        integrations_found=$((integrations_found + 1))
    fi
    
    if [ ! -z "$VITE_NETLIFY_ACCESS_TOKEN" ]; then
        echo -e "${GREEN}✓${NC} Netlify integration configured"
        integrations_found=$((integrations_found + 1))
    fi
    
    if [ ! -z "$VITE_SUPABASE_URL" ]; then
        echo -e "${GREEN}✓${NC} Supabase integration configured"
        integrations_found=$((integrations_found + 1))
    fi
    
    if [ $integrations_found -eq 0 ]; then
        echo -e "${YELLOW}ℹ${NC} No optional integrations configured (this is fine)"
    else
        echo -e "${GREEN}✓ Found $integrations_found optional integration(s)${NC}"
    fi
}

# Function to validate build directory
check_build() {
    echo ""
    echo "Checking Build Status..."
    echo "------------------------"
    
    if [ -d "./build" ]; then
        echo -e "${GREEN}✓${NC} Build directory exists"
        
        if [ -d "./build/client" ]; then
            echo -e "${GREEN}✓${NC} Client build found"
        else
            echo -e "${RED}✗${NC} Client build not found"
            echo "  Run: pnpm run build"
            return 1
        fi
    else
        echo -e "${YELLOW}⚠${NC} Build directory not found"
        echo "  This is normal for first deployment"
        echo "  Coolify will build automatically"
    fi
}

# Function to check Docker
check_docker() {
    echo ""
    echo "Checking Docker Configuration..."
    echo "--------------------------------"
    
    if command -v docker &> /dev/null; then
        echo -e "${GREEN}✓${NC} Docker is installed"
        
        if docker info &> /dev/null; then
            echo -e "${GREEN}✓${NC} Docker daemon is running"
        else
            echo -e "${RED}✗${NC} Docker daemon is not running"
            return 1
        fi
    else
        echo -e "${YELLOW}⚠${NC} Docker not found (only needed for local testing)"
    fi
    
    # Check if Dockerfile exists
    if [ -f "./Dockerfile" ]; then
        echo -e "${GREEN}✓${NC} Dockerfile found"
    else
        echo -e "${RED}✗${NC} Dockerfile not found!"
        return 1
    fi
    
    # Check if docker-compose.coolify.yaml exists
    if [ -f "./docker-compose.coolify.yaml" ]; then
        echo -e "${GREEN}✓${NC} docker-compose.coolify.yaml found"
    else
        echo -e "${YELLOW}⚠${NC} docker-compose.coolify.yaml not found"
    fi
}

# Main execution
main() {
    echo "Starting pre-deployment validation..."
    echo ""
    
    local errors=0
    
    # Run all checks
    check_docker || errors=$((errors + 1))
    check_ai_providers || errors=$((errors + 1))
    check_app_settings
    check_integrations
    check_build
    
    echo ""
    echo "================================================"
    if [ $errors -eq 0 ]; then
        echo -e "${GREEN}✓ All critical checks passed!${NC}"
        echo ""
        echo "Your configuration looks good for Coolify deployment."
        echo ""
        echo "Next steps:"
        echo "1. Push your code to your git repository"
        echo "2. In Coolify, add a new resource from your repository"
        echo "3. Configure environment variables in Coolify UI"
        echo "4. Deploy!"
        echo ""
        echo "See COOLIFY_DEPLOYMENT.md for detailed instructions."
    else
        echo -e "${RED}✗ Found $errors critical issue(s)${NC}"
        echo ""
        echo "Please fix the issues above before deploying."
        echo "See COOLIFY_DEPLOYMENT.md for help."
        exit 1
    fi
    echo "================================================"
}

# Run main function
main
