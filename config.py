"""
Configuration loading and proxy setup.
"""
import json
import os
from loguru import logger

from dotenv import load_dotenv

load_dotenv()

def load_config(config_path: str = "config.json") -> dict:
    """
    Load bot configuration from a JSON file.

    :param config_path: Path to the configuration file.
    :return: Configuration dictionary.
    :raises FileNotFoundError: If the config file is not found.
    :raises json.JSONDecodeError: If the file contains invalid JSON.
    """

    return {
        "bot_name": os.getenv("BOT_NAME"),
        "bot_token": os.getenv("BOT_TOKEN"),
        "bot_username": os.getenv("BOT_USERNAME"),
        "convert_workers": 5,
        "download_workers": 5,
        "allow_sticker_sets": True,
    }


def get_proxy_url(proxy_config: dict) -> str:
    """
    Get the proxy URL from the configuration.

    :param proxy_config: Dictionary containing proxy settings.
    :return: Formatted proxy URL or an empty string if not configured.
    """
    if not proxy_config.get("status", False):
        return ""

    proxy_type = proxy_config.get("type")
    host = proxy_config.get("host")
    port = proxy_config.get("port")
    username = proxy_config.get("username")
    password = proxy_config.get("password")

    if proxy_type not in ("http", "socks4", "socks5"):
        return ""

    if username and password:
        proxy_url = f"{proxy_type}://{username}:{password}@{host}:{port}"
    else:
        proxy_url = f"{proxy_type}://{host}:{port}"

    return proxy_url