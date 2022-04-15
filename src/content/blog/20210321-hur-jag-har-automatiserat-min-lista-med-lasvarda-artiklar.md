---
title: "Hur jag har automatiserat min lista med läsvärda artiklar"
date: "2021-03-21"
---

_Publicerat 2021-03-21_

När jag hittar en läsvärd artikel har jag två krav på upplevelsen: Den ska vara lättläst och tillgänglig när jag har tid. Därför sparar jag ner allt till [Pocket](https://getpocket.com/). Det är en tjänst som hämtar artikelns innehåll, gör det typografiskt lättläst och tillgängligt i en app.

En del av mina favoritbloggar skriver sällan och intressant (ja, du läste rätt: "sällan". Skulle det vara "ofta" hade jag inte hunnit med att läsa). Därför hade jag förut hjälp av IFTTT, som automatiskt skickade nya inlägg till min Pocketlista. Tyvärr kostar IFTTT pengar numera och jag är snål. Därför har jag byggt [Retel](https://github.com/gish/retel).

Retel är en snurra som automatiskt pingar bloggar och sparar ner nya inlägg.

## Ett kommandoradsverktyg

Principen var enkel. Var x:e minut skulle RSS-flödena kontrolleras för inlägg. De inlägg som var nyare än det som sist sparades till Pocket, skulle sparas till Pocket. Sen skulle det någonstans kommas ihåg en tidsstämpel, så vi kunde jämföra vid nästa körning och därmed undvika spara redan sparade inlägg.

Listan över bloggar och tidsstämplar behövde sparas på något persistent sätt. Valet föll på en SQL-databas. [Heroku](https://www.heroku.com/pricing) erbjöd en gratis-tier hos Cleardb. Med en modell i Sequelize innehållandes RSS-flödets adress och tidsstämpel, var verktyget kompetent.

Allt skrevs i TypeScript och kördes av node.js. Det blev lättast så, eftersom jag hade verktyg och boilerplate-kod färdiga. Med TypeScript kunde jag känna mig naivt säker på att koden skulle köra utan några större runtime-fel.

## Arkitektur

Till det här projektet passade Herokus gratis-dyno väl. Det är en dyno som stängs ned efter timeout och tar upp till en minut att starta. Det enda tillgänglighetskravet jag hade på Retel var att det skulle svara och snurra igenom flödena innan nästa schemalagda körning. Mellan körningarna behövde tjänsten inte vara igång. Alltså gjorde det inget att den startade långsamt och var nere.

Till det här jag lade jag till en [Cleardb](https://elements.heroku.com/addons/cleardb)-databas och [Herokus egna schemaläggare](https://elements.heroku.com/addons/scheduler). Dessutom slängde jag in [Papertrail](https://elements.heroku.com/addons/papertrail) för loggning.

Tack vare Herokus GitHub-integration kunde jag få automatiska deploys när något pushades till main-branchen. Tack för det!

## Autentisering mot Pockets API

Pocket erbjöd ett väldokumenterat [REST-API](https://getpocket.com/developer/). Här behövde jag registrera en applikation hos dem, för att kunna hämta API-nycklar. Autentiseringen mot Pocket sker via en variant av Oauth 2.0, där autentiserade anrop görs med ett access token. Eftersom autentiseringsflödet kräver att man surfar via applikationens sajt, via Pocket och sen skickas tillbaka till sajten, fick jag istället simulera en sajt via [Postman](https://www.postman.com/). Den dagen mitt access token slutar gälla får jag generera ett nytt via samma dans.

## Bakdaterade inlägg

Till en början valde jag att spara den senaste körningens tidpunkt som tidsstämpel i modellerna. Ett problem som jag upptäckte efter en veckas körning, var att en specifik bloggs inlägg inte sparades. Nya inlägg publicerades med ett datum äldre än föregående körnings. Mycket märkligt, men väldigt lite som kunde jag kunde påverka. Därför ändrade jag regel för tidsstämpeln att istället representera det senaste inläggets datum. Då blev det idiotsäkert och bloggens innehåll sparades enligt förväntan.

## Framtiden?

Jag har hört mig för om fler av mina vänner är intresserade, men de har inte samma behov som jag. De flesta RSS-flöden de läser innehåller brus. Retel bygger på att samtliga inlägg är någorlunda relevanta. Om du vill testa får du gärna deploya projektet till en egen Heroku-dyno och testa. Jag supportar gärna vid behov.
