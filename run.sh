#!/usr/bin/with-contenv bashio
#
# Gaggiuino Barista - Startup Script
#
# This script is executed when the Docker container starts.
# It reads configuration from Home Assistant and exports environment variables
# before launching the Python server.

echo "Starting Gaggiuino-Barista ..."

# Read Gaggiuino API base URL from add-on configuration
API_BASE=$(bashio::config 'api_base')
export API_BASE

# Read Anthropic API key for Claude Haiku (primary AI provider)
ANTHROPIC_API_KEY=$(bashio::config 'anthropic_api_key')
export ANTHROPIC_API_KEY

# Read Google Gemini API key (fallback AI provider)
GEMINI_API_KEY=$(bashio::config 'gemini_api_key')
export GEMINI_API_KEY

# Read Home Assistant notify service for mobile notifications
HA_NOTIFY_SERVICE=$(bashio::config 'ha_notify_service')
export HA_NOTIFY_SERVICE

# Read language setting for AI analysis output (en, el, it, de, es, fr)
LLM_LANGUAGE=$(bashio::config 'llm_language')
export LLM_LANGUAGE

# SUPERVISOR_TOKEN is auto-injected by HA — explicitly re-export to ensure
# subprocesses (plot_logic.py) inherit it along with other env vars
export SUPERVISOR_TOKEN

# Launch the Python server
python /app/src/server.py
