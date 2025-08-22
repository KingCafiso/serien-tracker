
# Serien-Tracker (AppleTV-Look) – Next.js + Supabase + TMDB + OMDb

**Features**
- AppleTV-ähnliches Frontend (Next.js App Router + Tailwind)
- Auth (Login/Registrierung) via Supabase
- Admin-Panel: Serien via TMDB hinzufügen
- Detailseite: Poster, deutsche Beschreibung, deutscher Trailer (wenn verfügbar), Anbieter in DE
- IMDb & Rotten Tomatoes Ratings via OMDb
- User-Features: Favorisieren, Liken, Bewerten (1–10), Kommentieren

## 1) Voraussetzungen
- Vercel Account (kostenlos)
- Supabase Projekt (kostenlos)
- TMDB API Key
- OMDb API Key (kostenloser Key auf omdbapi.com – wichtig: *&tomatoes=true* ist standard)

## 2) Supabase einrichten
1. Neues Projekt erstellen.
2. Öffne den SQL Editor in Supabase und führe den Inhalt von `supabase.sql` aus.
3. Kopiere **Project URL** und **anon public key** in deine Vercel Env Variablen.

### Tabellen & Policies (siehe `supabase.sql`)
- `profiles` (User-Profile)
- `series` (kuratiert vom Admin, referenziert `tmdb_id`)
- `favorites`, `likes`, `ratings`, `comments` (User-Interaktionen)

> Admin-Definition: E-Mails in der Env `ADMIN_EMAILS` dürfen /admin aufrufen.

## 3) Deploy (1-Click)
1. Fork dieses Repo **oder** lade es als ZIP in ein neues GitHub Repo hoch.
2. Klicke in Vercel auf **New Project** → wähle dein Repo.
3. Setze **Environment Variables** in Vercel:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `ADMIN_EMAILS`
   - `TMDB_API_KEY`
   - `OMDB_API_KEY`
4. Deploy starten. Fertig!

## 4) Lokale Entwicklung (optional)
```bash
npm install
cp .env.example .env.local
# .env.local ausfüllen
npm run dev
```

## 5) Admin-Panel
- Besuche `/admin` (du musst mit einer Admin-Mail eingeloggt sein).
- Suche Serien (TMDB) und klicke **Hinzufügen**, um sie in `series` zu speichern.

## 6) Hinweise
- Trailer: Wir versuchen deutsche Videos von TMDB (`language=de-DE`). Wenn keiner vorhanden ist, fällt es auf englische Trailer zurück.
- Ratings: OMDb liefert IMDb und Rotten Tomatoes Werte, wenn verfügbar.
- Anbieter in Deutschland: TMDB Watch Providers (`watch/providers?language=de-DE`).
