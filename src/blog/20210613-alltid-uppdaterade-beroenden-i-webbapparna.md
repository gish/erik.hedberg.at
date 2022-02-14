# Alltid uppdaterade beroenden i webapparna

_Publicerat 2021-06-13_

Kan du säga något tråkigare än att hålla sin applikation uppdaterad med senaste versioner av beroenden? Inte? Tänkte väl det. Men det är ju så värdefullt. Buggfixar lösta, dokumentationen är inte för ny och alla bra features är tillgängliga.

Så hur löser man det? Jag har valt att bumpa mina TypeScript- och JavaScript-projekt automatiskt med [Dependabot](https://docs.github.com/en/code-security/supply-chain-security/keeping-your-dependencies-updated-automatically). Det är en tjänst, numera ägd av GitHub, som automatiskt identifierar och uppdaterar projektets beroenden. När ett beroende har kommit i en ny version, skapar Dependabot en pull request mot main-branchen med en uppdatering av package.json (och eventuellt package-lock.json eller yarn.lock).

Tidigare kunde Dependabot också merga sin PR automatiskt, beroende på projektets inställning. Med transformationen av tjänsten från att vara extern till [inbyggd i GitHub](https://docs.github.com/en/code-security/supply-chain-security/keeping-your-dependencies-updated-automatically/upgrading-from-dependabotcom-to-github-native-dependabot), har denna funktionalitet tagits bort. Istället går det att lösa med en action, [koj-co/dependabot-pr-action](https://github.com/PabioHQ/dependabot-pr-action). Eftersom jag är lat låter jag alla in-range-uppdateringar med gröna byggen mergas.

Hittills har det här fungerat exemplariskt. Varje morgon kan jag scrolla igenom mina GitHub-notiser och se hur paket har uppdaterats och nya versioner av apparna deployats. Mig veterligen har ingen app gått sönder av en uppdatering ("there is no such thing as a jinx"). Då kör jag inga unit-tester utan förlitar mig bara på gröna byggen (lutar mig stadigt mot type-checking i TypeScript).

Det enda problemet hittills har varit när Sentry bumpat sina paket. En av mina applikationer har beroenden till tre av dessa (@sentry/react, @sentry/node, @sentry/tracing). Sentry släpper alltid nya versioner av dem samtidigt. Då kommer tre separata pull requests, som var och en får röda byggen. Så fort de sammanfogas till en pull request, blir allt grönt. Jag lever lite cowboy och mergar dem till main manuellt, trots röd flagg. När alla tre är mergade blir main så småningom grön och deployas.

Är du nyfiken på en enkelt setup kan du spana in applikationen Retel. Den har [en action](https://github.com/gish/retel/blob/main/.github/workflows/ci.yml) för att bygga PRs mot main, [en action](https://github.com/gish/retel/blob/main/.github/workflows/merge-pr.yml) för att kontinuerligt merga PRs skapade av Dependabot och [en konfiguration för Dependabot](https://github.com/gish/retel/blob/main/.github/dependabot.yml).
