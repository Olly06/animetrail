# AnimeTrail

Estensione per **Firefox e Chrome/Chromium** (Manifest V3) che traccia gli episodi visti su AnimeSaturn, AnimeWorld e AnimeUnity, li sincronizza tra i tuoi dispositivi e aggiorna la lista MyAnimeList (API v2, OAuth2 PKCE).

## Installazione per sviluppo

**Firefox** (121+): `about:debugging` → *Questo Firefox* → *Carica componente aggiuntivo temporaneo…* → `src/manifest.json`.

**Chrome / Edge / Brave**: `chrome://extensions` → attiva *Modalità sviluppatore* → *Carica estensione non pacchettizzata* → seleziona la cartella `src/`.

## Configurazione MyAnimeList
1. Crea un'app su https://myanimelist.net/apiconfig (App Type: **other**).
2. In *App Redirect URL* inserisci **entrambi** gli URL (uno per riga), così la stessa app funziona su tutti e due i browser:
   ```
   <URL di Firefox, mostrato nelle Impostazioni del popup>
   https://benghggecnglpgoelfmafldckmabgano.chromiumapp.org/        (Chrome, caricata da src/)
   https://gecempaochilmgfdjcmefppkcefkoeip.chromiumapp.org/        (Chrome Web Store)
   ```
   Verifica che coincidano con quelli mostrati nel popup (Impostazioni → "Usa una tua app MAL").
3. L'estensione include un Client ID integrato (`BUILTIN_CLIENT_ID` in `src/lib/common.js`):
   per usarne uno tuo incollalo nello stesso punto del popup e fai Login.

## Sincronizzazione
I dati usano `storage.sync`: si sincronizzano tra i Firefox (Firefox Sync, voce "Componenti aggiuntivi")
oppure tra i Chrome (Chrome Sync, voce "Estensioni"). **Non** si sincronizzano tra Firefox e Chrome:
per passare da uno all'altro usa Esporta/Importa JSON, oppure lascia che MAL faccia da riferimento comune.

## Note tecniche sulla compatibilità
- `src/lib/common.js` espone `chrome` come `browser` su Chromium (le API MV3 di Chrome restituiscono già Promise).
- Il manifest dichiara sia `background.scripts` (usato da Firefox) sia `background.service_worker` (`src/background/sw.js`, usato da Chrome).
- Il campo `key` del manifest fissa l'ID dell'estensione in Chrome, così il redirect URL è identico su ogni PC.

Per costruire i pacchetti: `./scripts/build.sh` (crea gli ZIP in `dist/`).
Per installarla in modo permanente, firmarla e pubblicarla vedi [docs/DISTRIBUZIONE.md](docs/DISTRIBUZIONE.md).
Informativa sulla privacy: [PRIVACY.md](PRIVACY.md). Idee future: [docs/TODO.md](docs/TODO.md).

## Struttura

```
├── README.md  LICENSE  PRIVACY.md
├── src/                 # l'estensione (è la cartella da caricare nei browser)
│   ├── manifest.json
│   ├── background/      # background.js (logica), sw.js (entry service worker Chrome)
│   ├── content/         # content.js/css iniettati su AnimeSaturn, AnimeWorld, AnimeUnity
│   ├── popup/           # popup.html/css/js (popup e pagina intera)
│   ├── lib/             # common.js, mal_api.js (condivisi)
│   └── icons/
├── docs/                # DISTRIBUZIONE.md (firma e pubblicazione), TODO.md
├── store/               # amo-metadata.json e screenshots/ per le schede degli store
├── scripts/build.sh     # crea i pacchetti in dist/
└── dist/                # pacchetti generati (ignorata da git)
```
