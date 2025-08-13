# VLESS + Reality on Railway

This repository deploys an Xray (VLESS + Reality) server on Railway.

## Environment Variables (set in Railway → Variables)
- `UUID` (e.g. bd522e31-a3bb-4aa4-a5cb-841352b68b9b)
- `PORT` (default 443)
- `REALITY_PUBLIC_KEY`
- `REALITY_SHORT_ID`
- `REALITY_SERVER_NAME` (use the Railway domain after deploy or your own SNI)

## Deploy Steps
1. Create a new **public** GitHub repository and upload these files to the repo root:
   `Dockerfile`, `entrypoint.sh`, `xray_config.template.json`, `README.md`
2. On Railway → **New Project** → **Deploy from GitHub Repo** → select your repo.
3. Open **Variables** and set the env vars above.
4. Wait for the deployment to succeed. Use the assigned Railway domain as your server address.

If your repo has **subfolders** wrapping these files, Railway may not detect `Dockerfile`.
Make sure the `Dockerfile` is at the repository root.
