---
title: "Ett tmux-plugin för information i statusraden"
date: "2022-05-28"
---

Något jag uppskattar med [tmux](https://github.com/tmux/tmux) är dess statusrad. Där har jag koll på tiden och datorns batterinivå. En sak jag dock saknat har varit huruvida min stämpelklocka är startad eller stoppad. Därför har de senaste månaderna spenderats med att klura ut hur man skriver ett sådant plugin. Som stämpelklocka använder jag kommandoradsverktyget [Watson](https://github.com/TailorDev/Watson).

Tmux pluginhanterare [tpm](https://github.com/tmux-plugins/tpm) är sparsamt dokumenterad. Det finns mest exempel på olika typer av plugins, vilka alla saknar dokumentation för utvecklare. Därför har jag med eller mindre klurat med hjälp av reverse-engineering. Som utvecklare är man van med pratig dokumentation. Det har varit frustrerande att inte ha tillgång till det i tpms fall.

## Principerna

Statusraden konfigureras i tmux-konfigurationsfil. Inställningen är en sträng som innehåller placeholders. Varje placeholder motsvarar någon information från ett plugin.

```bash
set -g status-right '#{watson_status} | %H:%M'
```

Ett plugin ska ha en exekverbar fil som i mitt fall heter `watson-status.tmux`. Den skrivs oftast i något shell-format. Filens uppgift är att läsa konfigurationen av statusraden och ersätta en placeholder med informationen. Till exempel kan en placeholder vara `#{watson_status}`. Motsvarande script har i uppgift att skriva ut statusen.

Det viktiga är att den exekverbara filen byter ut placeholdern mot sökvägen till det script som skriver ut värdet. Jag trodde initialt att placeholdern skulle ersättas med själva värdet. Men så var inte fallet. Här är exempel på hur ovanstående konfiguration blir, när konfigurationen lästs in att mitt plugin:

```bash
(/home/ehedberg/.tmux/plugins/tmux-watson-status/scripts/status.sh) | %H:%M
```

Pluginet för stämpelklockan anammar just den här principen. Huvudfilen har metoder för att traversera alla associerade placeholders och göra en interpolering av inställningen. Övrigt script har bara till uppgift att skriva ut om klockan är på eller av.

## Förbättringar

För tpm har jag förslag på några förbättringar som hade underlättat min utveckling. Eftersom det är open source misstänker jag att jag har mig själv att skylla. Jag kan ju faktiskt själv bidra till just de här förbättringarna.

### Dokumentation

Exempel räcker inte. En manual för plugins för statusraden hade varit otroligt behjälplig. Det finns förstås [en generell dokumentation](https://github.com/tmux-plugins/tpm/blob/master/docs/how_to_create_plugin.md), men den täcker inte det här specifika fallet.

### Logga alla fel

Om fel sökväg till script anges, scriptet inte kan köra eller skapar allmän oreda, ges ingen feedback. Man får klura och gissa vad som kan vara fel.

## Mer plugins!

Jag gillar som sagt tmux och nu när jag fått fason på tpm, kommer jag fortsätta anpassa min miljö.

Härnäst lutar det åt att jag skriver ett plugin som hämtar aktuell utomhustemperatur från givaren vid garaget. Med kunskapen från mitt trevande med mitt första plugin, hoppas jag det går på timmar - inte månader.

Pluginet för Watsons status [finns här](https://github.com/gish/tmux-watson-status).
