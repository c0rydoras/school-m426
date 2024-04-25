"""The Backends APP."""

from __future__ import annotations

from typing import TypedDict

from fastapi import FastAPI

app = FastAPI(root_path="/api/v1")


class Message(TypedDict):
    """Message TypedDict."""

    message: str


@app.get("/hello")
async def hello() -> Message:
    """Hello World."""
    return {"message": "Hello World"}
