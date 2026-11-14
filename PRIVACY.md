# Informativa sulla privacy — AnimeTrail

*Ultimo aggiornamento: 14 novembre 2026*

AnimeTrail è un'estensione per Firefox e Chrome che traccia gli episodi di anime guardati su AnimeSaturn,
AnimeWorld e AnimeUnity e, se lo vuoi, aggiorna la tua lista MyAnimeList (MAL).
**Lo sviluppatore non gestisce alcun server e non raccoglie alcun dato.** Tutto resta nel tuo browser
o viene scambiato direttamente tra il tuo browser e MAL.

## Quali dati vengono salvati

Per ogni anime che guardi:
titolo, episodi visti, ultimo episodio e data di visione, ID MAL, numero di episodi, URL della copertina e
l'identificativo dell'ultimo episodio (necessario a riaprirlo).
Inoltre le impostazioni (scrobble attivo, secondi minimi di visione, sito di ricerca preferito, domini dei siti,
ed eventuale Client ID MAL personale).

- **Storage sincronizzato del browser** (Firefox Sync / Chrome Sync): lista degli anime e impostazioni, così
  da averle su tutti i tuoi dispositivi. La sincronizzazione è gestita dal tuo browser, non da noi.
- **Storage locale** (solo questo dispositivo): token di accesso a MAL, nome e foto del profilo MAL,
  cache dei metadati, stato delle sincronizzazioni, voci archiviate per limiti di spazio.

## Con chi vengono condivisi

- **Nessuno, tranne MyAnimeList** e solo se esegui il login. In quel caso l'estensione comunica con
  `myanimelist.net` e `api.myanimelist.net` per: autenticarti (OAuth2 PKCE; la password MAL non passa mai
  dall'estensione), cercare un anime per titolo, leggere la tua lista e aggiornare episodi visti e stato.
  Il trattamento da parte di MAL è regolato dalla loro informativa.
- **I siti di streaming** (AnimeSaturn, AnimeWorld, AnimeUnity) ricevono le normali richieste di navigazione e,
  per leggere i metadati di un anime, una richiesta alla pagina dell'anime. L'estensione non invia loro
  la tua lista né altri dati personali.
- Nessuna analisi, pubblicità, telemetria o profilazione. Nessun dato è venduto o ceduto a terzi.

## Perché servono i permessi

| Permesso | Motivo |
|---|---|
| `storage` | Salvare lista e impostazioni |
| `identity` | Aprire il login MAL (OAuth) |
| `alarms` | Ritentare le sincronizzazioni MAL in sospeso |
| Accesso ai tre siti | Rilevare l'episodio guardato e leggere titolo, ID MAL e numero di episodi |
| Accesso a MAL | Login e aggiornamento della tua lista |

La dichiarazione "dati raccolti" del manifest (`browsingActivity`, `authenticationInfo`) indica che
l'estensione *elabora* la cronologia di visione e il token MAL **solo nel tuo browser e verso MAL**,
come descritto sopra.

## Controllo e cancellazione

- **Logout** (Impostazioni): elimina il token MAL dal dispositivo.
- **Elimina** una voce dallo Storico: la rimuove dalla lista e dalla sincronizzazione del browser.
- **Esporta / Importa**: copia dei tuoi dati in un file che gestisci tu.
- **Disinstallare** l'estensione rimuove i dati locali; quelli sincronizzati si cancellano dalle
  impostazioni di sincronizzazione del tuo browser.
- Per revocare l'accesso lato MAL: <https://myanimelist.net/apiconfig> → app autorizzate.

## Altro

AnimeTrail è un progetto indipendente, **non affiliato né approvato** da MyAnimeList, AnimeSaturn,
AnimeWorld o AnimeUnity. Il codice è open source (licenza MIT) e verificabile su
<https://github.com/Olly06/animetrail>. Domande o segnalazioni: apri una issue su quel repository.

---

# Privacy policy (English summary)

AnimeTrail stores your watch history (anime titles, watched episodes, MAL IDs, cover URLs) and settings in the
browser's own storage, synced by your browser's sync service, and your MAL token locally on the device.
It talks only to the supported streaming sites (normal browsing plus fetching an anime page for metadata)
and, if you log in, to MyAnimeList (OAuth2 PKCE) to search titles and update your list.
The developer runs no servers and collects no data; there is no analytics, advertising or sale of data.
You can log out, delete entries, export/import your data, or uninstall at any time.
AnimeTrail is not affiliated with MyAnimeList or any of the streaming sites.
