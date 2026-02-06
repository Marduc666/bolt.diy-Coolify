# Deploying bolt.diy on Coolify

This guide provides step-by-step instructions for deploying bolt.diy on your Coolify instance.

## Prerequisites

- A running Coolify instance (v4.0 or later recommended)
- Access to your Coolify dashboard
- At least one AI provider API key (OpenAI, Anthropic, etc.)
- Minimum 2GB RAM and 2 CPU cores recommended

## Quick Start

### Option 1: Deploy from GitHub (Recommended)

1. **Add New Resource in Coolify**
   - Navigate to your Coolify dashboard
   - Click **"+ New"** → **"Public Repository"**
   - Enter repository URL: `https://github.com/Marduc666/bolt.diy-Coolify`
   - Select branch: `stable` (for production) or `main` (for latest features)

2. **Configure Build Settings**
   - Build Pack: **Docker**
   - Dockerfile Location: `./Dockerfile`
   - Docker Build Target: `bolt-ai-production`
   - Port: `5173`

3. **Set Environment Variables**
   
   Click on **"Environment Variables"** and add your API keys. At minimum, you need one AI provider:

   ```bash
   # Required: Choose at least one AI provider
   ANTHROPIC_API_KEY=your_anthropic_key_here
   # OR
   OPENAI_API_KEY=your_openai_key_here
   # OR
   GROQ_API_KEY=your_groq_key_here
   
   # Recommended settings
   NODE_ENV=production
   VITE_LOG_LEVEL=info
   DEFAULT_NUM_CTX=32768
   ```

   See [Environment Variables](#environment-variables) section for complete list.

4. **Deploy**
   - Click **"Deploy"**
   - Wait for build to complete (5-10 minutes first time)
   - Access your deployment at the provided URL

### Option 2: Deploy with Docker Compose

1. **Add New Resource in Coolify**
   - Click **"+ New"** → **"Public Repository"**
   - Enter repository URL: `https://github.com/Marduc666/bolt.diy-Coolify`
   - Select branch: `stable`

2. **Configure Docker Compose**
   - Build Pack: **Docker Compose**
   - Docker Compose File: `docker-compose.coolify.yaml`

3. **Set Environment Variables** (same as Option 1)

4. **Deploy**

## Environment Variables

### Required Variables

You must configure **at least one** AI provider. Here are the most popular options:

#### Anthropic Claude (Recommended)
```bash
ANTHROPIC_API_KEY=sk-ant-xxxxx
```
Get your key from: https://console.anthropic.com/

#### OpenAI GPT
```bash
OPENAI_API_KEY=sk-xxxxx
```
Get your key from: https://platform.openai.com/api-keys

#### Groq (Fast & Free Tier Available)
```bash
GROQ_API_KEY=gsk_xxxxx
```
Get your key from: https://console.groq.com/keys

### Optional AI Providers

<details>
<summary>Click to expand all available providers</summary>

```bash
# Google Gemini
GOOGLE_GENERATIVE_AI_API_KEY=your_key

# DeepSeek
DEEPSEEK_API_KEY=your_key

# Mistral
MISTRAL_API_KEY=your_key

# Cohere
COHERE_API_KEY=your_key

# Together AI
TOGETHER_API_KEY=your_key

# X.AI (Grok)
XAI_API_KEY=your_key

# Perplexity
PERPLEXITY_API_KEY=your_key

# HuggingFace
HuggingFace_API_KEY=your_key

# OpenRouter (Access to multiple providers)
OPEN_ROUTER_API_KEY=your_key

# Moonshot (Kimi)
MOONSHOT_API_KEY=your_key

# Hyperbolic
HYPERBOLIC_API_KEY=your_key

# GitHub Models
GITHUB_API_KEY=github_pat_xxxxx

# AWS Bedrock (JSON format)
AWS_BEDROCK_CONFIG={"region":"us-east-1","accessKeyId":"xxx","secretAccessKey":"xxx"}
```

</details>

### Local AI Providers

If you're running local AI models, configure these:

```bash
# Ollama (must be accessible from Coolify)
OLLAMA_API_BASE_URL=http://your-ollama-host:11434

# LM Studio
LMSTUDIO_API_BASE_URL=http://your-lmstudio-host:1234

# OpenAI-compatible endpoints
OPENAI_LIKE_API_BASE_URL=http://your-endpoint
OPENAI_LIKE_API_KEY=your_key
```

> [!WARNING]
> When using local providers, ensure they are accessible from your Coolify instance. Use `host.docker.internal` for services on the same machine, or configure proper networking.

### Integration Services (Optional)

```bash
# GitHub Integration (for repo import/export)
VITE_GITHUB_ACCESS_TOKEN=ghp_xxxxx
VITE_GITHUB_TOKEN_TYPE=classic

# GitLab Integration
VITE_GITLAB_ACCESS_TOKEN=glpat-xxxxx
VITE_GITLAB_URL=https://gitlab.com
VITE_GITLAB_TOKEN_TYPE=personal-access-token

# Vercel Deployment
VITE_VERCEL_ACCESS_TOKEN=your_token

# Netlify Deployment
VITE_NETLIFY_ACCESS_TOKEN=your_token

# Supabase Integration
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your_anon_key
VITE_SUPABASE_ACCESS_TOKEN=your_token
```

### Application Settings

```bash
# Environment
NODE_ENV=production

# Logging (debug, info, warn, error)
VITE_LOG_LEVEL=info

# Context window for local models
DEFAULT_NUM_CTX=32768

# Port (Coolify will auto-detect)
PORT=5173

# Public URL (Coolify sets this automatically)
VITE_PUBLIC_APP_URL=https://your-domain.com
```

## Coolify-Specific Configuration

### Health Checks

The application includes a built-in health check at `http://localhost:5173/`. Coolify will automatically use this.

**Recommended Health Check Settings:**
- **Interval**: 10s
- **Timeout**: 3s
- **Start Period**: 30s (first deployment may take longer)
- **Retries**: 5

### Resource Limits

**Minimum Requirements:**
- Memory: 2GB
- CPU: 2 cores
- Storage: 5GB

**Recommended for Production:**
- Memory: 4GB
- CPU: 4 cores
- Storage: 10GB

Configure in Coolify under **"Resources"** tab.

### Persistent Storage

bolt.diy stores data in the container. For persistence across deployments:

1. In Coolify, go to **"Storages"** tab
2. Add a volume:
   - **Name**: `bolt-data`
   - **Mount Path**: `/app/data`
   - **Host Path**: Let Coolify manage

### Custom Domain

1. In Coolify, go to **"Domains"** tab
2. Click **"Add Domain"**
3. Enter your domain (e.g., `bolt.yourdomain.com`)
4. Coolify will automatically configure SSL with Let's Encrypt

### Environment Variables in Coolify UI

To add environment variables in Coolify:

1. Navigate to your application
2. Click **"Environment Variables"** tab
3. Click **"+ Add"**
4. Enter variable name and value
5. Click **"Save"**
6. Redeploy the application

> [!TIP]
> You can bulk import variables by clicking **"Bulk Edit"** and pasting in KEY=VALUE format.

## Deployment Workflow

### Initial Deployment

1. Configure all required environment variables
2. Click **"Deploy"**
3. Monitor build logs for any errors
4. Once deployed, access the health check endpoint
5. Open the application and configure your first AI provider in settings

### Updates

To update to the latest version:

1. In Coolify, click **"Redeploy"**
2. Coolify will pull the latest code and rebuild
3. Zero-downtime deployment is handled automatically

### Rollback

If something goes wrong:

1. Go to **"Deployments"** tab
2. Find a previous successful deployment
3. Click **"Redeploy"** on that version

## Troubleshooting

### Build Fails

**Issue**: Docker build fails with memory errors

**Solution**: Increase build resources in Coolify settings:
```bash
# In Coolify, set build args:
NODE_OPTIONS=--max-old-space-size=4096
```

### Application Won't Start

**Issue**: Container starts but health check fails

**Solution**: 
1. Check logs in Coolify dashboard
2. Verify at least one AI provider API key is set
3. Ensure PORT is set to 5173
4. Check that NODE_ENV=production

### API Keys Not Working

**Issue**: AI providers not responding

**Solution**:
1. Verify API keys are correct (no extra spaces)
2. Check provider status pages
3. Review application logs for specific errors
4. Test API keys using provider's playground

### Connection to Local Ollama/LMStudio

**Issue**: Can't connect to local AI models

**Solution**:
1. Use `host.docker.internal` instead of `localhost`
2. Ensure firewall allows connections
3. For external servers, use full IP/domain
4. Example: `OLLAMA_API_BASE_URL=http://host.docker.internal:11434`

### Slow Performance

**Issue**: Application is slow or unresponsive

**Solution**:
1. Increase memory allocation (minimum 4GB recommended)
2. Increase CPU cores (minimum 4 recommended)
3. Check AI provider response times
4. Review logs for bottlenecks

### WebContainer Issues

**Issue**: Projects fail to run in WebContainer

**Solution**:
1. Ensure sufficient memory (4GB+)
2. Check browser console for errors
3. Try a different AI model (Claude Sonnet 3.5 recommended)
4. Clear browser cache and reload

## Advanced Configuration

### Using Multiple AI Providers

You can configure multiple providers and switch between them in the UI:

```bash
ANTHROPIC_API_KEY=sk-ant-xxxxx
OPENAI_API_KEY=sk-xxxxx
GROQ_API_KEY=gsk_xxxxx
GOOGLE_GENERATIVE_AI_API_KEY=xxxxx
```

Users can then select their preferred provider per conversation.

### Custom Build Arguments

For advanced users, you can pass custom build arguments in Coolify:

1. Go to **"Build"** tab
2. Add build arguments:
   ```
   VITE_LOG_LEVEL=debug
   DEFAULT_NUM_CTX=65536
   ```

### Running in Development Mode

For testing, you can deploy in development mode:

1. Change Docker target to `development`
2. Set `NODE_ENV=development`
3. Enable hot reload (not recommended for production)

### Connecting External Databases

If you need persistent storage with PostgreSQL/MySQL:

1. Create a database in Coolify
2. Add connection string to environment:
   ```bash
   DATABASE_URL=postgresql://user:pass@host:5432/db
   ```

## Security Best Practices

> [!CAUTION]
> **API Key Security**: Never commit API keys to git. Always use Coolify's environment variable system.

1. **Use Environment Variables**: Store all secrets in Coolify's encrypted environment variables
2. **Enable HTTPS**: Always use SSL/TLS (Coolify handles this automatically)
3. **Restrict Access**: Use Coolify's authentication features if needed
4. **Regular Updates**: Keep bolt.diy updated by redeploying regularly
5. **Monitor Logs**: Regularly check logs for suspicious activity
6. **API Key Rotation**: Rotate API keys periodically

## Performance Optimization

### Caching

Enable caching for better performance:
- Coolify automatically handles HTTP caching
- Configure CDN if serving globally

### Scaling

For high traffic:
1. Increase resources (CPU/Memory)
2. Consider horizontal scaling (multiple instances)
3. Use a load balancer (Coolify Pro feature)

## Monitoring

### Application Logs

Access logs in Coolify:
1. Navigate to your application
2. Click **"Logs"** tab
3. View real-time logs or download historical logs

### Metrics

Monitor application health:
- CPU usage
- Memory usage
- Request count
- Response times

Available in Coolify's **"Metrics"** tab.

## Support and Resources

- **bolt.diy Documentation**: https://stackblitz-labs.github.io/bolt.diy/
- **Community Forum**: https://thinktank.ottomator.ai
- **GitHub Issues**: https://github.com/stackblitz-labs/bolt.diy/issues
- **Coolify Documentation**: https://coolify.io/docs

## FAQ

**Q: Which AI provider should I use?**
A: For best results, use Anthropic Claude 3.5 Sonnet or OpenAI GPT-4. Groq offers fast inference with a generous free tier.

**Q: Can I use multiple providers simultaneously?**
A: Yes! Configure multiple API keys and switch between them in the application settings.

**Q: How much does it cost to run?**
A: Server costs depend on your Coolify hosting. AI provider costs vary by usage - most offer pay-as-you-go pricing.

**Q: Can I run this without internet access?**
A: Yes, if you use local providers like Ollama or LM Studio. Configure the appropriate base URLs.

**Q: Is my code/data secure?**
A: Code runs in isolated WebContainers in your browser. API calls go directly to your chosen AI provider. Review each provider's privacy policy.

**Q: Can I customize the system prompts?**
A: Yes, the application allows customization through the settings interface.

**Q: Does this work on mobile?**
A: The UI is responsive, but for best experience use a desktop browser. WebContainers require desktop browser features.

## License

bolt.diy is MIT licensed. However, it uses WebContainers API which requires licensing for commercial production use. See the [main README](README.md#licensing) for details.

---

**Need help?** Join the [bolt.diy community](https://thinktank.ottomator.ai) for support and discussions!
