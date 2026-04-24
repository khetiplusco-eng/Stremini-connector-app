# Stremini AI Platform - Production Guide

This document outlines the steps required to take the Stremini AI application from the scaffolded state to a fully functional, production-ready system. 

The architecture consists of a **Flutter mobile application** (frontend) and a **Cloudflare Workers API** (backend) leveraging **Gemini 2.5 Flash** and **Supabase**.

---

## Phase 1: Environment Setup & Prerequisites

Before you can build the code, you need to configure your local development environment.

1. **Install Flutter**: [Download & Install Flutter](https://docs.flutter.dev/get-started/install). Verify installation by running `flutter doctor` in your terminal.
2. **Install Node.js & npm**: [Download Node.js](https://nodejs.org/) (Required for the Cloudflare Worker).
3. **Install Wrangler CLI**: Run `npm install -g wrangler` to install the official Cloudflare Workers deployment tool.
4. **Create a Supabase Account**: Sign up at [Supabase.com](https://supabase.com/) and create a new project.

---

## Phase 2: Generating API Keys & Credentials

You must generate API keys and credentials for all the intelligent connectors to work.

### 1. Gemini AI (Core Reasoning Engine)
- Go to Google AI Studio: [https://aistudio.google.com/](https://aistudio.google.com/)
- Generate an API key. This will power the `gemini-2.5-flash` model in the backend.

### 2. Supabase (Database & Auth)
- In your Supabase Project Dashboard, go to **Settings > API**.
- Copy the **Project URL** and the **`service_role` secret**. 
- *Note: You will use the `service_role` key securely in your backend Worker. Never expose this key in the Flutter frontend.*

### 3. Google Workspace (Gmail & Drive Connectors)
- Go to the [Google Cloud Console](https://console.cloud.google.com/).
- Create a new project, enable the **Gmail API** and **Google Drive API**.
- Configure the OAuth Consent Screen and create **OAuth 2.0 Client IDs**.
- Download the Client ID and Client Secret.

### 4. Notion Integration (Public App)
If you want your users to connect *their own* Notion workspaces to the Stremini app, you cannot use an Internal Integration. You must create a **Public Integration (OAuth)**:
- Go to [Notion My Integrations](https://www.notion.so/my-integrations).
- Click **New integration** and select **Public (OAuth)** under the distribution settings.
- Fill out the OAuth domains and redirect URIs. For this deployment, your exact redirect URI will be:
  `https://stremini-ai-backend.vishwajeetadkine705.workers.dev/api/connectors/notion/callback`
- Use the provided **Client ID** and **Client Secret** to implement the OAuth flow in your backend so users can authorize Stremini to access their workspaces.

### 5. WhatsApp Business (Meta)
- Go to the [Meta Developer Dashboard](https://developers.facebook.com/).
- Create a new App (Type: Business).
- Add the **WhatsApp** product.
- Generate a permanent System User Token with `whatsapp_business_messaging` permissions.

---

## Phase 3: Backend Deployment (Cloudflare Workers)

Once you have your credentials, you need to inject them into the backend and deploy.

### Local Development
1. Navigate to the backend directory: `cd backend`
2. Run `npm install` to install dependencies (Hono, GenAI, Supabase JS).
3. Copy `.env.example` to `.env` and fill in your keys.
4. Run `npm run dev` to start the local development server.

### Deploying to Production
Cloudflare Workers use "Secrets" rather than `.env` files for production.
1. Authenticate Wrangler: `wrangler login`
2. Add your secrets one by one using the terminal:
   ```bash
   wrangler secret put SUPABASE_URL
   wrangler secret put SUPABASE_SERVICE_ROLE_KEY
   wrangler secret put GEMINI_API_KEY
   # Repeat for GMAIL, NOTION, and WHATSAPP keys
   ```
3. Deploy the worker: `npm run deploy`
4. *Copy the final deployed URL (e.g., `https://stremini-ai-backend.<your-username>.workers.dev`). You will need this for the Flutter app.*

---

## Phase 4: Frontend Build & Deployment (Flutter)

### Initializing the App
1. Navigate to the frontend directory: `cd stremini_app`
2. Run `flutter pub get` to download all necessary UI packages (GoRouter, Google Fonts, etc.).

### Connecting to the Backend
- Open `lib/core/constants.dart` in your Flutter project.
- The `apiUrl` is already hooked up to your live server: `https://stremini-ai-backend.vishwajeetadkine705.workers.dev`.
- All network requests in your app will now route directly to your live AI reasoning engine.

### Compiling for Mobile
1. **Android**: Run `flutter build apk` or `flutter build appbundle` (for Google Play Store).
2. **iOS**: Open the `ios/Runner.xcworkspace` in Xcode, configure your Apple Developer signing certificates, and run `flutter build ios`.

---

## Phase 5: Final Code Implementation Checklist

The scaffolded code provides the UI and the structural foundation. To make the app "smart", you must implement the following business logic:

- [ ] **Auth Flow:** Connect a Supabase login screen to the Flutter app.
- [ ] **Connector Logic (Backend):** Implement the OAuth exchange logic in the Cloudflare Worker for Gmail and Drive so users can securely grant access.
- [ ] **Tool Calling (Gemini):** Update `backend/src/index.ts` to use Gemini's `tools` parameter. Teach the model how to call a function like `fetch_gmail_invoices()` based on the user's prompt.
- [ ] **Webhook Handlers:** Create a `POST /webhook/whatsapp` route in the Cloudflare Worker to receive incoming messages from the Meta API and pipe them into Gemini.
- [ ] **State Management:** Implement `Provider` or `Riverpod` in Flutter to dynamically update the execution graph UI (in `WorkflowScreen`) based on real-time responses from the backend.
