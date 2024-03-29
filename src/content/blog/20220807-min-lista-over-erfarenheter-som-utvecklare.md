---
title: "Min lista över erfarenheter som utvecklare"
date: "2022-08-07"
draft: false
description: "Här kommer en löpande brain-dump av vad jag tar med mig från min karriär som mjukvaruutvecklare."
---

Här kommer en löpande brain-dump av vad jag tar med mig från min karriär som mjukvaruutvecklare.

## Mjukvaruutveckling
1. En dålig standard är bättre än ingen standard. Det gör det lättare att följa koden.
1. När en ny standard anammas, se till att projektet följer den nya standarden. Se punkt 1.
1. Om data inte behöver muteras, gör inte det. Skapa ny data och använd den istället. Då undviker du sidoeffekter.
1. Typa alltid allting. Ingen kommer tacka dig för att du "i framtiden" kommer typa det som är otypat.
1. GitHub Actions som CI fungerar tillräckligt bra för att man inte ska behöva sätta upp egen CI-miljö.
1. Pipelines ska vara snabba. Ingen utvecklare vill behöva vänta på att få igenom sin kodändring.

## Organisation
1. Gör ops till en så liten kostnad som möjligt. Funkar det att köra tjänsten på en VPS istället för i ett Kubernets-kluster - gör det.
1. Utvecklare i ett produkt-team ska sträva efter att besitta kompetens om hela stacken. Är det svårt bör man tänka efter om stacken är för komplex.
1. Det är alltid värt tiden att med hela teamet (åtminstone de som är tillgängliga) diskutera hur en user story kan lösas. I många fall blir slutsatsen en enklare lösning.