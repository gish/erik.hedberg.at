---
title: "Tips för att jobba med konfiguration av Home Assistant"
date: "2022-10-21"
draft: false
description: "Tips och tricks som gör det lättare att konfigurera Home Assistant"
---

Hemma hos mig styr [Home Assistant](https://www.home-assistant.io/) (HA) fönsterlampor, laddare till cykeln och rapporterar när diskmaskinen är klar. Det som började med att jag inte ville ha tickande ljudet från timers och har bara fortsatt med automatiseringar för att göra hemmet mer praktiskt. Här kommer några av mina erfarenheter av att konfigurera HA.

## Säkerhetskopiera till Google Drive

Min installation blev korrupt för några månader sen. Tack vare att jag löpande hade säkerhetskopierat konfigurationen till Google Drive kunde jag återställa och vara på banan inom någon timme. Inga integrationer behövde sättas upp på nytt. Efter återställningen var det som att komma tillbaka till dashboarden som innan kraschen.

Installera [Home Assistant Google Drive Backup](https://community.home-assistant.io/t/add-on-home-assistant-google-drive-backup/107928) nu. Vänta inte till imorgon.

## Representera ett beräknat state med `input_boolean`

Genom att göra en lös koppling mellan trigger och action blir det lättare att testa och utöka automationer. När något händer ska en entitet av typen `input_boolean` ändra tillstånd. Det som ska utföras utifrån ändringen av tillståndet skrivs i en separat automation.

Ta vår diskmaskin som exempel. När den är klar ska min telefon få en notis och högtalaren i vardagsrummet annonsera det med ett meddelade. Lösningen är att ha en entitet som heter `dishwasher_running`. En automation sätter den till `true` när diskmaskinen har haft en viss förbrukning en viss tid och `false` när förbrukningen gått ner. En annan automation reagerar på växlingen från `true` till `false` och tar hand om notiserna. [Kolla automationen här](https://github.com/gish/home-assistant-config/blob/8c946f7947d09cea55cd9d9be1dfcc9422a271cb/automations/dishwasher.yaml).

Vad är bra med den lösningen?

- Separation of concerns!
- Det blir kortare block att förstå i konfigurationen.
- När automationen ska testas räcker det med att växla state för entiteten i GUI:t.
- Det är lätt att jacka in en till händelse när diskmaskinen går igång eller slutar.
- Dessutom blir det i förlängningen lättare att kombinera flera tillstånd i en automation.

## Kontrollera konfigurationen innan den driftsätts

Jag vet inte hur många gånger jag fått göra om konfigurationen p g a stavfel, ogiltig referens eller YAML-syntaxen. Det är en bökig process att verifiera att konfigurationen fungerar.

Eftersom git tar hand om versioneringen, slog det mig att det borde kunna säga till om något är galet. Tack vare inspiration från GitHub Actions för HA, har jag lyckats skapa en git-hook som verifierar konfigurationen innan commit. Koden ser ut som följer.

```bash
$ docker run --rm \
  --entrypoint "" \
  -v $(pwd):/workspace \
  --workdir /workspace \
  "ghcr.io/home-assistant/home-assistant:stable" \
    python -m homeassistant \
      --config "." \
      --script check_config
```

Som du ser är det HA som laddas hem och kör konfigurationskontrollen. Det är en tämligen snabb operation, som sparar många frustrerande minuter.
