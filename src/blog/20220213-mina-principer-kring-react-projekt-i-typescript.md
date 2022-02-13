# Mina principer kring React-projekt i TypeScript

_Publicerat 2022-02-13_

Efter några år med utveckling av React-sajter i TypeScript, börjar jag få bestämda åsikter om vilka principer ett projekt ska förhålla sig till. Principerna gäller inte för kombinationen TypeScript och React, utan kan tillämpas på de två fenomenen oberoende av varandra.

## Typa alltid allt

En av poängen med TypeScript är att få JavaScript med typer. Det finns inget som hjälper så bra som att få det här rätt. Hur många gånger har man inte loggat ett objekt i konsolen, för att se vilka nycklar som finns och vilka typer de har?

Använd primitiver i så liten usträckning som möjligt. En parameter som tar namn bara kan anta vissa värden, ska inte anges som en sträng. Den ska istället vara en typ med värden för namnen.

## Skippa index-filer som bara exponerar komponenter

Editorn hittar ändå komponenterna. När skrevs en import manuellt senast? Att skriva index-filer som exporterar en komponent är bara onödig tid. Det finns en poäng i att exportera allt från en index-fil - att samla alla imports från samma sökväg. Det ser stiligare ut i toppen av filen som konsumerar alla imports. Men det är allt.

## Komponenter ska skrivas som funktionella

En anledning räcker: [React-teamet rekommenderar](https://reactjs.org/docs/hooks-faq.html#should-i-use-hooks-classes-or-a-mix-of-both) att de är funktionella komponenter. Hooks är så lite magi det kan bli. Det blir lättare att resonera kring en komponent om man bara behöver observera renderingsfasen.

Hooks kommer vara lättare att testa än klassens lifecycle-metoder. En hook anropar oftast en funktion som spottar ur sig ett värde. Låt den funktionen testas, till skillnad från hela React-komponenten som du får göra för en klassbaserad komponent.

## Välj en standard, även om den är dålig

Poängen med en standard är att inte behova tänka. Många beslut kring kodens design kan tas en gång för att sedan inte behöva reflekteras over. Istället kan du som utvecklare bry dig om business-logiken.

Vad betyder det att ha en dålig standard? Till exempel kan namngivningen av komponenter göras med snake_case, funktioner aldrig ha en namngiven export, alla typer placeras i en gemensam fil för typ-definitioner. Det är inget fel i sig, men kan lätt skapa problem med förvirring, vid debuggning och en monstruös fil.

Ändras standarden, se till att all kod följer den. Ändras standarden utan att kodbasen följer med, kommer det snart finnas flera olika standarder som en ny utvecklare måste förhålla sig till.

Vad betyder det här? Följ en bra standard från början.

## Vad är dina principer?

Jag är intresserad av vilka principer du följer i dina projekt. Hör av dig med ett mail eller via Slack.
