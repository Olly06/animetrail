# Installare l'estensione su tutti i browser

Un componente aggiuntivo caricato da `about:debugging` è **temporaneo**: sparisce a ogni riavvio di Firefox.
Per installarlo in modo permanente, Firefox (versione stabile) richiede un file `.xpi` **firmato da Mozilla**.

## Opzione consigliata: firma "unlisted" su AMO

"Unlisted" significa che Mozilla firma il file ma **non** lo pubblica nello store pubblico.
La firma è automatica e arriva in pochi minuti. Lo installi una volta per browser e da lì si aggiorna da solo.

1. **Chiavi API**: generale su <https://addons.mozilla.org/developers/addon/api/key/> (serve un account Firefox).
2. **Firma**, dalla radice del progetto (l'estensione vive in `src/`):
   ```bash
   npx web-ext sign --source-dir=src --channel=unlisted --artifacts-dir=dist \
     --api-key=TUA_JWT_ISSUER --api-secret=TUO_JWT_SECRET
   ```
   Il file `.xpi` firmato finisce in `dist/`. Meglio passare le chiavi come variabili d'ambiente
   (`WEB_EXT_API_KEY`, `WEB_EXT_API_SECRET`) per non lasciarle nella cronologia della shell.
3. **Pubblicazione**: carica il `.xpi` in una **GitHub Release** di questo repository.
4. **Installazione**: in ogni browser apri il link al `.xpi`; Firefox chiede di installarlo. Va fatto una sola volta.
5. **Aggiornamenti automatici**: aggiungi `update_url` nel manifest, puntato a un file `updates.json` ospitato nel repo:
   ```json
   "browser_specific_settings": {
     "gecko": {
       "id": "animetrail@local.ext",
       "update_url": "https://raw.githubusercontent.com/Olly06/animetrail/main/updates.json"
     }
   }
   ```
   Esempio di `updates.json`:
   ```json
   {
     "addons": {
       "animetrail@local.ext": {
         "updates": [
           {
             "version": "1.0.0",
             "update_link": "https://github.com/Olly06/animetrail/releases/download/v1.0.0/animetrail-1.0.0.xpi"
           }
         ]
       }
     }
   }
   ```
   A ogni nuova versione: aumenta `version` nel manifest, firma, carica la Release e aggiungi una voce in `updates.json`.

### Da sapere
- **Repo privato**: per scaricare il `.xpi` e `updates.json` senza login, il repository deve essere **pubblico**,
  oppure i file vanno ospitati altrove (per esempio su GitHub Pages).
- **Campo obbligatorio**: AMO ora richiede nel manifest `browser_specific_settings.gecko.data_collection_permissions`;
  senza quel campo la firma viene rifiutata.
- **Redirect URL MAL**: l'ID dell'estensione resta lo stesso, quindi il Redirect URL registrato su MyAnimeList continua a funzionare.

## Alternative e limiti

- **Pubblicazione nello store AMO ("listed")**: è l'unico modo in cui Firefox Sync installa l'estensione da solo
  su tutti i browser (con l'opzione "Componenti aggiuntivi" attiva). Però passa per una revisione di Mozilla,
  e un'estensione legata a un sito di streaming non ufficiale rischia di essere rifiutata.
- **Firefox Developer Edition o Nightly**: lì si può impostare `xpinstall.signatures.required = false` in `about:config`
  e installare il `.xpi` senza firma. Nella versione stabile di Firefox quell'impostazione non funziona.

## Automazione possibile

Un workflow GitHub Actions può firmare l'estensione e creare la Release a ogni tag `v1.x`,
usando le chiavi API salvate nei **Secrets** del repository (`AMO_JWT_ISSUER`, `AMO_JWT_SECRET`).

## Chrome / Chromium

- **Uso personale**: *Carica estensione non pacchettizzata* da `chrome://extensions` (Modalità sviluppatore) resta
  installata anche dopo il riavvio, a differenza di Firefox. Va ricaricata a mano dopo ogni `git pull`.
  Grazie al campo `key` nel manifest l'ID è sempre `benghggecnglpgoelfmafldckmabgano` su ogni PC.
- **Chrome Web Store**: richiede un account sviluppatore (quota una tantum) e una revisione. Lo store assegna
  la propria chiave: prima di caricare lo ZIP va rimosso il campo `key` dal manifest e va registrato su MAL
  il nuovo redirect URL `https://<id-store>.chromiumapp.org/`.
- I file `.crx` installati fuori dallo store sono bloccati da Chrome su Windows e macOS.

## Pubblicazione sullo store AMO (listed)

1. **Client ID MAL integrato** (consigliato): registra un'app su <https://myanimelist.net/apiconfig>
   (tipo *Other*) e metti il suo Client ID in `BUILTIN_CLIENT_ID` in `src/lib/common.js`.
   Come Redirect URL registra quello mostrato nelle Impostazioni dell'estensione (dipende dall'ID dell'add-on,
   quindi è uguale per tutti gli utenti). Senza questo valore ogni utente deve creare la propria app MAL.
2. **Privacy policy**: usa `PRIVACY.md` (link: `https://github.com/Olly06/animetrail/blob/main/PRIVACY.md`).
3. **Invio**: dal pannello sviluppatori AMO scegli *On this site*, oppure
   `npx web-ext sign --source-dir=src --channel=listed --artifacts-dir=dist --amo-metadata=store/amo-metadata.json`.
   Con il pannello carica `dist/animetrail-<versione>-firefox.zip`; i testi della scheda sono in `store/amo-metadata.json`
   e gli screenshot in `store/screenshots/`.
4. **Note per il revisore**: indica che l'estensione non ha server propri, che il login MAL è opzionale
   e fornisci istruzioni o un account di prova.

## Costruire i pacchetti

```bash
./scripts/build.sh
```
Crea in `dist/`:
- `animetrail-<versione>-firefox.zip`: da firmare o inviare ad AMO.
- `animetrail-<versione>-chrome-store.zip`: senza il campo `key`, da caricare sul Chrome Web Store.

Prima di ogni invio: aumenta `version` in `src/manifest.json` e controlla che la descrizione non superi
i 132 caratteri (limite di Chrome; lo script lo segnala).

## Chrome Web Store: Redirect URL

L'ID assegnato dallo store è `gecempaochilmgfdjcmefppkcefkoeip`: sull'app MAL deve essere registrato
`https://gecempaochilmgfdjcmefppkcefkoeip.chromiumapp.org/` (oltre agli URL di Firefox e di sviluppo).
