<div align="center">

<img src="src/icons/icon.svg" width="96" alt="AnimeTrail">

# AnimeTrail

**Ricorda dove sei arrivato con ogni anime e tieni aggiornata la tua lista MyAnimeList.**

Estensione per Firefox e Chrome (Manifest V3) · [Privacy](PRIVACY.md) · [Licenza MIT](LICENSE)

</div>

---

## Cosa fa

- **Segna gli episodi visti da solo.** Dopo il tempo che scegli (20 secondi di default) sulla pagina del player, l'episodio viene registrato.
- **"Continua"** nel popup e sulla pagina dell'anime: riapri l'ultimo episodio con un clic.
- **Evidenzia gli episodi già visti** nelle liste dei siti.
- **Aggiorna MyAnimeList** (episodi visti e stato *watching/completed*) con il login ufficiale MAL. È opzionale.
- **Importa da MAL** gli anime già completati.
- **Sincronizza** la lista tra i tuoi dispositivi con la sincronizzazione del browser.
- **Etichette AS / AW / AU** che indicano su quale sito stavi guardando, e un'impostazione per scegliere il sito preferito per la ricerca.
- **Backup:** esporta e importa tutto in un file JSON.

## Siti supportati

| Sito | Etichetta |
|---|---|
| AnimeSaturn | `AS` |
| AnimeWorld | `AW` |
| AnimeUnity | `AU` |

AnimeTrail è un progetto indipendente e **non è affiliato** a MyAnimeList né a questi siti.

## Installazione

> Le versioni sugli store sono in revisione. Nel frattempo puoi caricare l'estensione a mano (vedi sotto).

- **Firefox:** pagina su addons.mozilla.org *(link in arrivo)*
- **Chrome / Edge / Brave:** pagina sul Chrome Web Store *(link in arrivo)*

### Da sorgente (sviluppo)

```bash
git clone https://github.com/Olly06/animetrail.git
```

- **Firefox:** `about:debugging` → *Questo Firefox* → *Carica componente aggiuntivo temporaneo…* → seleziona `src/manifest.json`. Resta attiva fino al riavvio.
- **Chrome / Edge / Brave:** `chrome://extensions` → attiva *Modalità sviluppatore* → *Carica estensione non pacchettizzata* → seleziona la cartella `src/`.

## Primo avvio

1. Guarda un episodio su uno dei siti supportati: dopo qualche secondo compare nel popup, scheda **In corso**.
2. *(Facoltativo)* Apri **Impostazioni** → **Login con MAL** per sincronizzare la tua lista MyAnimeList. Non serve nessuna configurazione: usa il Client ID integrato.

## Sincronizzazione

I dati usano la sincronizzazione del browser: si allineano tra i Firefox (Firefox Sync) oppure tra i Chrome (Chrome Sync), **non** tra i due. Per passare da uno all'altro usa Esporta/Importa, oppure lascia che MyAnimeList faccia da riferimento comune.

## Privacy

Nessun server dello sviluppatore, nessuna telemetria, nessuna pubblicità. I dati restano nel tuo browser; l'unico servizio esterno contattato è MyAnimeList, solo se fai il login. Dettagli in [PRIVACY.md](PRIVACY.md).

## Per sviluppatori

```
├── src/              # l'estensione (la cartella da caricare nei browser)
│   ├── background/   # logica, storage, scrobble su MAL (sw.js: entry per Chrome)
│   ├── content/      # script iniettato nei siti: rileva episodi, evidenzia i visti
│   ├── popup/        # popup e pagina intera
│   ├── lib/          # common.js, mal_api.js
│   └── icons/
├── docs/             # guida alla pubblicazione, TODO
├── store/            # testi e screenshot per le schede degli store
├── scripts/build.sh  # crea i pacchetti in dist/
└── dist/             # pacchetti generati (ignorata da git)
```

**Pacchetti:** `./scripts/build.sh` crea in `dist/` lo ZIP per Firefox e quello per il Chrome Web Store.
**Firma e pubblicazione:** vedi [docs/DISTRIBUZIONE.md](docs/DISTRIBUZIONE.md). **Idee future:** [docs/TODO.md](docs/TODO.md).

<details>
<summary>Note tecniche</summary>

- Un solo manifest per entrambi i browser: dichiara `background.scripts` (Firefox) e `background.service_worker` (Chrome).
- `src/lib/common.js` espone `chrome` come `browser` su Chromium.
- Ogni anime è identificato da uno slug: `nome-id` (AnimeSaturn), `nome.id` (AnimeWorld), `id_nome` (AnimeUnity).
- Il campo `key` del manifest fissa l'ID in Chrome per lo sviluppo; il build per lo store lo rimuove.
- **Usare una propria app MAL:** registrala su <https://myanimelist.net/apiconfig> (tipo *other*), aggiungi come Redirect URL quello mostrato in Impostazioni → *Usa una tua app MAL*, e incolla il tuo Client ID nello stesso punto.

</details>

## Licenza

[MIT](LICENSE)
