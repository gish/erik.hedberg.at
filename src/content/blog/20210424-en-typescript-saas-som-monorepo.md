---
title: En TypeScript-SaaS som monorepo
date: "2021-04-24"
---

_Publicerat 2021-04-24_

För projektet [Enkla Kvitton](http://enklakvitton.se/), har jag valt att testa monorepo-arkitekturen. Enkla Kvitton är en webapp för redovisning av kvitton.

Här kommer en lista över de saker som jag tycker är utmärkande för den arkitekturen. Mycket är nog detsamma för andra monorepon. Vad vet jag? Det här är hittills mitt första och enda projekt.

Inledningsvis kan det vara bra att veta det är ett system som består av ett API och två klienter, samt ett schemalagt rapporteringsjobb. Den ena klienten är appen för att redovisa kvittot och den andra ett supportverktyg. Allt är skrivet i TypesScript. Repositoryt är ett privat repo på GitHub.

## Samma beroenden - samma uppgraderingar

Tack vare approachen till bibliotek hos yarn workspace, samlas alla beroenden i roten av projektet. Det innebär att de applikationer som använder samma bibliotek, har samma version installerad. Jag behöver inte uppgradera på två ställen när det släpps en ny version. Istället räcker det med att bumpa ett beroende. Dessutom sköter [Dependabot](https://dependabot.com/) uppdateringarna, så jag slipper nästan allt själv.

Det kan verka farligt att låta något automatiskt bumpa, men hittills har det också gott förvånansvärt bra. Fördelen att alltid ha senaste versionerna av allt överväger risken det kan medföra.

## En commit kommer med alla nödvändiga ändringar

När API:t uppdateras behöver konsumenterna räta in sig i ledet. Istället för att uppdatera API-repot i ett steg och sedan klienterna i nästa, kan jag göra allt i samma commit. Då behöver jag inte tänka på vilken ordning saker ska rullas ut i. Dessutom minskar jag risken att glömma uppdatera en av konsumenterna.

Tack vare typningen som kommer med TypeScript, gnäller också min editor när en klient inte har anpassat sig. Mina fingrar och tår räcker inte till för att hålla räkningen på hur många gånger det har räddat mig.

## Det är lätt att dela kod

Klienterna baseras på React, med Redux som state-manager. Mycket av vad de gör är i grund och botten lika. De ska hämta kundens registrerade kvitton, skapa nya registreringar, visa företag man har tillgång till, etcetera. De kan i mångt och mycket ha snarlika state. Därför finns ett delat bibliotek för ducks. Tack vare yarn workspace (igen) kan det delade biblioteket ligga i monorepot, kompileras när det är ändrat och importeras till klienterna. Så fort paketet är byggt börjar TypeScript påpeka vad som behöver ändras hos konsumenterna. Paketet måste byggas, eftersom de betraktas som vilket beroende som helst.

Sama sak gäller för API-biblioteket. Antingen kan klienterna hämta data till statet med en action, eller så kan de direkt skicka ett anrop till API:t via klient-bibliotekt. Även här konsumeras det av klienterna och likaså ducks-biblioteket.

## Flera deploys vid en push

Så fort en commit pushas till main-branchen, deployas allt till nya noder hos [Heroku](https://www.heroku.com/). Jag behöver inte tänka på i vilken ordning saker ska deployas, eller vilka specifika applikationer som har ändrats. Än så länge har vi klarat oss utan mismatch mellan API och klient. Den enda risken är att jag infört en breaking change som frammanar en bugg under de tre minuter som API:t har hunnit få sin nya nod, medan klienterna fortfarande rullas ut.

Här är vi två entiteter som uppdaterar. Jag pushar kod och Dependabot pushar nya versioner av bibliotek.

Som hängslen och livrem kör GitHub en rudimentär check i CI. Det ser till att bygga alla applikationer och paket. Heroku inväntar grönt ljus innan deploy. Enhetstester har fått stryka på foten.

## Det var lite klurigt att välja verktyg

Min approach brukar vara "implementation före analys", när det tillåter. Som verktyg för monorepo började jag med [Lerna](https://github.com/lerna/lerna). Jag hade hört gott om det och alla krav verkade uppfyllas. Men när Dependabot ville blanda sig in i leken (och jag ovillkorligen vill ha den tjänsten för TypeScript-projekt) stötte jag på patrull. Tydligen fanns det inte stöd hos Dependabot för Lerna. Därför fick jag tänka om. Som trogen npm-användare blev det till att istället använda yarn. För ett år sedan hade npm inte samma workspace-feature som yarn. Det tog en dag att strukturera om projektet, få deploys och GitHub actions på plats. Det svåraste var att hitta ett buildpack för Heroku som passade. Där fick jag forka ett befintligt och lägga till byggsteg för de delade paketen.

## Kör allt lokalt med en docker-compose

Följden av att ha allt samlat i ett repository, blir att jag kan köra alla tjänster och appar lokalt i Docker med en enda docker-compose-fil. Miljövariablerna specas i en lokal .env-fil och propageras till applikationerna, via docker-compose.

I tidigare projekt har jag maintainat konfigurationen för Docker i varje repository, med en docker-compose i ett eget.

## Det här kommer jag att fortsätta med

För framtida projekt kommer jag fortsätta på inslagen väg. Det har varit utomordentligt enkelt att göra uppdateringar, med liten risk för buggar. Här är det förstås viktigt att veta att all kod varit skriven i samma språk. Hur man ska göra med en fruktsallad av språk, har jag inte klurat på än.
