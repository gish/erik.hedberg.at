---
title: "Du får bara committa till main"
date: "2023-07-22"
description: "Mina tankar om fördelarna med att skippa feature-brancher och bara committa till main."
images: ["/images/20230722-du-far-bara-committa-till-main.png"]
---

_Publicerat 2023-07-22_

Utgå från att du bara får göra commits till ditt projekts huvudbranch main. Fenomenet feature-brancher finns inte. När du gjort en commit till main och pushar, triggas en CI-pipeline och en automatiskt deploy till staging-miljön körs.

Nu kan du helt plötsligt inte göra pull requests. Hur ska du nu få feedback på din kod från dina teammedlemmar? Hur ska du veta om testerna, som körs vid pull requests, går igenom? All trygghet försvinner. Eller?

Du behöver inte få feedback på koden som är skriven. Den är billigare att få feedback på kod som kommer att skrivas. Sannolikheten att det blir rätt från början ökar. Hela teamet, eller delar, kan tillsammans planera den feature som ska skrivas. Vilka ändringar och tillägg behövs? Hur ska vi uttrycka dem? Hur omfattande planering som behövs är upp till teamets mognadsgrad.

När koden skrivs kan det göras av samma delar av teamet.  En invändning till det kan vara att teamet har olika kompetenser. Ni är full stack. En person jobbar med backend, en annan sköter infrastrukturen och en tredje gör frontend. Vem vet, ni kanske är ett stort team med ytterligare kompetenser? Bra! Här finns ett ypperligt tillfälle att bli mer t-format. Teamet får en bred kompetens, där varje medlem också har en spets. Ni minskar buss-faktorn.
n
Sitter ni tillsammans behöver ni inte pull requests. Ni behöver inte ge feedback i efterhand. Ni som skriver har förtroende av teamet att ni skriver korrekt kod och har mandat att pusha till main. Pipelinen med tester körs. Är den grön kan ni deploya. Är den röd? Pipelinen är blockad, ingen annan kan deploya till produktionsmiljön. Men det löser ni lätt med en revert-commit. Att skriva om historiken i main är förbjudet, även om det är lockande att ta bort den felande committen.

Är planerad feature stor? Tar det en vecka att implementera? Blir det många ändringar att hålla reda på och en läskigt stor commit till main? Perfekt! Nu tvingas ni bryta ner allt till små, isolerade ändringar, som ni löpande kan pusha och deploya till produktion. Inget behöver vara aktivt eller synligt innan allt är klart. Tills vidare går det att dölja med feature-flaggor. Ännu mer tillfredställande är det om man skippar flaggor och istället gör det nya synligt via den sista commiten. Är ändringen till exempel en knapp för export av data, visa knappen i den sista committen. Är ändringen ett batch-jobb som ska köras, lägg till schemaläggningen sist. Då minimeras risken av att koden nedlusad av gamla, ouppstädade flaggor.

Fördelen med små commits är att ni också kan be en till teammedlem om feedback. Visa ändringen via ert lokala diff-verktyg. Om feedbacken kommer med förbättringsförslag, skriv dem tillsammans. Då har kompetensen helt plötsligt spridits till ytterligare en person.

En invändning kan vara att ni är ett stort team. Många vill pusha till main. Om pipelinen för main blir röd är den blockad. Ingen kan deploya. Världen går under. Det är absolut viktigt att hålla main grön. Det är allas prioritet. Har man pushat får man också vänta på resultatet och åtgärda ett eventuellt fel. Huvudproblemet är dock att det jobbas med för många saker parallellt. Teamet är för stort eller grupperna som skriver för små. En bra grej är att sätta upp och respektera en WIP-limit. Prata om det på retron och justera utifrån hur ni jobbar.

Det här är ett arbetssätt som jag tycker är eftersträvansvärt. Nu slipper du kostnaden för feature-brancher. Det kostar att skapa, underhålla och integrera dem i huvudbranchen. Dessutom blir inte arbetet isolerat från resten av teamet.
