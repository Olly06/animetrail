# TODO

## Domini aggiuntivi inseriti dall'utente ("mirror")

**Obiettivo.** I siti supportati cambiano spesso dominio (es. `.ac` → `.so`). Oggi ogni cambio richiede
una nuova versione e una nuova revisione sugli store. L'utente deve poter aggiungere da solo un dominio
di un sito già supportato.

**Idea.**
- Nuova sezione "Siti" nelle Impostazioni: l'utente inserisce un dominio e sceglie il tipo
  (stile AnimeSaturn / AnimeWorld / AnimeUnity).
- L'estensione chiede il permesso solo per quel dominio (`optional_host_permissions` +
  `permissions.request`) e registra lo script già presente nel pacchetto con
  `scripting.registerContentScripts` (nessun codice remoto: consentito dagli store).
- Il tipo di sito si legge da una mappa dominio → tipo salvata nello storage, al posto dei controlli
  fissi sul nome (`IS_WORLD` / `IS_UNITY` in `content.js` e `baseKey` in `common.js`).
- Il dominio aggiunto alimenta anche i link del popup e la ricerca (`baseWorld`, `baseUnity`, `base`).

**Fuori ambito.** Siti con struttura diversa: ognuno richiede un adattatore dedicato (numero episodio,
titolo, link MAL, lista episodi) e quindi un aggiornamento dell'estensione.

**Attenzioni.**
- Un permesso host opzionale ampio può attirare più attenzione in revisione: chiedere solo l'origine inserita.
- Mostrare all'utente l'avviso del browser e spiegare cosa verrà attivato.
- Da fare dopo l'approvazione delle versioni attuali (AMO e Chrome Web Store), per non cambiare i permessi
  durante la revisione.
- Gestire la rimozione di un dominio (revoca del permesso e deregistrazione dello script).
