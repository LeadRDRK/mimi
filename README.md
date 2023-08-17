# Mimi
Mimi is a library that allows you to easily interact with the Misskey API. The goal is to have a simple and intuitive API.

**Currently experimental and not well tested. Use at your own risk.**

Compatible with Misskey v13 or later, with some support for forks (FoundKey, Firefish). v12 is supported on a best-effort basis; expect things to break. There is currently no plan to implement extra features from forks, and `admin` endpoints.

# Supported APIs
This is a list of supported API categories as shown in the API docs and their estimated coverage (not listed = 0%).
- MiAuth
- Account (90%)
    - Missing: `clips/*`
- Meta (100%)
- Notes (95%)
    - Missing: `channels/timeline`
- Notifications (100%)
- Users (100%)
- Following (100%)
- Reactions (100%)

*The coverage does not include `admin` endpoints.*

Streaming support:
- Channels (40%)
    - Supported: `main`, `localTimeline`, `globalTimeline`, `hybridTimeline`, `homeTimeline`
- Read notification
- Note subscription (100%)
