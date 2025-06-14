from pathlib import Path

BASE_PATH = Path(__file__).resolve().parent.parent.parent
NPS_DIR = BASE_PATH / "NPSdir"
TORRENT_DIR = BASE_PATH / "TORRENTdir"

BOT_KEY: str | None = None
BOT_URL: str = "http://example.com/"
OVERRIDE_TORRENTS: bool = True
SUCCESS_MESSAGE: str = (
    "served by owntinfoil @ aagaming.me"
)

HOST: str = "0.0.0.0"  # noqa: S104
PORT: int = 8080

__all__ = (
    "BASE_PATH",
    "BOT_KEY",
    "BOT_URL",
    "HOST",
    "NPS_DIR",
    "OVERRIDE_TORRENTS",
    "PORT",
    "SUCCESS_MESSAGE",
    "TORRENT_DIR",
)
