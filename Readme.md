[![Cours 1](https://img.shields.io/badge/Cours_1-Hors--ligne-red.svg)](https://github.com/cours-patrickFournier/mat8186-r-avance/tree/automne2019/1-introduction)
[![Cours 2](https://img.shields.io/badge/Cours_2-Hors--ligne-red.svg)](https://github.com/cours-patrickFournier/mat8186-r-avance/tree/automne2019/2-debug_profile_benchmark)
[![Cours 3](https://img.shields.io/badge/Cours_3-Hors--ligne-red.svg)](https://github.com/cours-patrickFournier/mat8186-r-avance/tree/automne2019/3-performance)
[![Cours 4](https://img.shields.io/badge/Cours_4-Hors--ligne-red.svg)](https://github.com/cours-patrickFournier/mat8186-r-avance/tree/automne2019/4-oop)
[![Cours 5](https://img.shields.io/badge/Cours_5-Hors--ligne-red.svg)](https://github.com/cours-patrickFournier/mat8186-r-avance/tree/automne2019/5-programmation_concurrente)
[![Cours 6](https://img.shields.io/badge/Cours_6-Hors--ligne-red.svg)](https://github.com/cours-patrickFournier/mat8186-r-avance/tree/automne2019/6-packaging)

# MAT8186: Techniques avancées en programmation statistiques R
## Bienvenue!
Tout d'abord, je vous souhaite la bienvenue sur le dépôt GitHub de
votre cours. Vous y trouverez:
* Slides de chacun des cours.
* Devoirs.
* Liens utiles / matériel supplémentaire.

Veuillez noter que nous n'utiliserons *pas* Moodle pour ce cours; *le
dépôt contiendra donc l'ensemble du matériel nécessaire*.

## Informations.
* Lien Zoom pour le cours: https://uqam.zoom.us/j/93180864930
* Horaire: de 10h30 à 12h30 le
  * lundi: 14 et 28 septembre, 12 et 26 octobre.
  * mercredi: 16 et 30 septembre, 14 et 28 octobre.

## Coordonnées.
Vous pouvez me joindre:
* par e-mail: fournier.patrick@uqam.ca
* en personne: PK-5323.

Étant donné la pandémie, privilégiez les communication par e-mail ou
Zoom. Nous ne nous rencontrerons en personne que si nécessaire.

## Bilbiographie.
La bibliographie du cours est disponible sur Mendeley:
https://www.mendeley.com/community/mat8186-techniques-avancees-en-programmation-statistiques-r/
Elle est en construction permanente, des documents pourraient y être ajouté
au courant de la session.

## Logiciels à installer.
Les logiciels suivants sont nécessaires pour le cours.
* R version >= 4.0 (https://cran.r-project.org/).
* RStudio version >= 1.3 (https://www.rstudio.com/products/rstudio/).
* Git version >= 2.28 (https://git-scm.com/).

Si vous possédez déjà ces logiciels, je vous suggère de profiter du
début de la session pour vous assurer qu'ils sont bien à jour.

## Packages R à installer.
Les packages ci-dessous sont nécessaires à l'exécution des scripts R
présents sur ce dépôt. Ils sont tous disponibles sur CRAN et peuvent
donc être installés par un simple appel à `install.packages`.
* devtools
* doParallel
* foreach
* magrittr
* microbenchmark
* proftools
* pryr
* roxygen2
* testthat

Si vous possédez déjà ces packages, je vous suggère de profiter du
début de la session pour vous assurer qu'ils sont à jour. Pour ce
faire, à l'intérieur d'une session R, appellez

``` R
update.packages(ask = FALSE)
```

## Comment utiliser ce dépôt.
La bonne utilisation de git et, dans une moindre mesure, GitHub, fait
partie intégrante du cours. Git est à la base un outil en ligne de
commande possédant une quantité impressionnante de
fonctionnalité. Malheureusement, cela le rend relativement difficile à
maîtriser. Toutefois, RStudio fourni une interface simplifiée aux
fonctionnalités de git auxquelles nous ferrons appel. Cette section
vous liste les étapes nécessaires à la bonne utilisation du dépôt pour
le cours.

À la fin de cette section, vous aurez
1. une copie locale du dépôt qui sera en mesure de recevoir les
   changements que j'y apporterai et
2. une copie en ligne de votre dépôt local à laquelle j'aurai accès.

![Schema git](readme_pictures/schema_git.png)

### Créez votre compte GitHub.
Le processus est standard, vous devriez facilement y arriver.

### Surveillez le dépôt.
Cette étape n'est pas nécessaire mais je vous recommande de surveiller
ce dépôt. Vous serez ainsi averti des modifications lui étant
apportés. Pour ce faire,
1. Cliquez sur le bouton `Watch` au coin supérieur droit de cette page;
   un menu déroulant apparaîtra.
2. Cliquez sur `Watching`.

![Screenshot, watch repo](readme_pictures/watch_repo.png)

### Créez un nouveau dépôt privé
Su la page principale de votre compte, cliquez sur le bouton
«Create repository».

![Screenshot, create repo](readme_pictures/create_repo.png)

Par la suite, donnez un nom et décrivez votre nouveau dépôt. Noubliez pas
de le rendre privé!

![Screenshot, create_repo2](readme_pictures/create_repo2.png)

### Dupliquez le dépôt.
Cette étape a pour but de créer votre propre copie personnelle du
dépôt. Pour la suite du cours, *vous allez travailler exclusivement dans
cette copie*.

La procédure permettant de dupliquer le dépôt est décrite en détail
[ici](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository).

Une fois cela fait, donnez-moi accès à votre dépôt en m'ajoutant comme
collaborateur.

1. Cliquez sur le bouton `Settings` au coin supérieur droit de la page
de *votre dépôt*.

![Screenshot, settings](readme_pictures/private_settings.png)

2. Cliquez sur `Collaborators` à gauche.

![Screenshot, collaborators](readme_pictures/private_collaborator.png)

5. Cherchez mon nom d'utilisateur (ps-pat) et ajoutez-moi comme collaborateur.

![Screenshot, settings](readme_pictures/private_addCollaborator.png)

### Créez un dépôt local.
Bien qu'il soit possible de travailler directement sur votre dépôt
GitHub, cela n'est pas très pratique. La meilleure façon de procéder
est de créer un troisième dépôt localisé sur votre ordinateur. Cela
se fait aisément à l'aide de RStudio.
1. Ouvrez RStudio.
2. Sous le menu `File`, cliquez sur `New Project`.
3. Dans la boîte de dialogue, cliquez sur `Version Control`.

![Screenshot, new project](readme_pictures/local_repo1.png)

4. Dans l'écran suivant, choisissez `Git`.

![Screenshot, new project git](readme_pictures/local_repo2.png)

5. Dans l'écran suivant, inscrivez l'URL de *mon dépôt*:
   https://github.com/cours-patrickFournier/mat8186-r-avance.git. Celui-ci
   vous est donné lorsque vous cliquez sur le bouton `Code` au coin
   supérieur droit de la page de mon dépôt.

![Screenshot, new project git](readme_pictures/local_repo3.png)

6. Cliquez sur `Create Project`.

### Ajustement des remotes.
Félicitation, vous disposez maintenant d'une copie locale de votre
dépôt! Toutefois, vous n'êtes pas tout à fait au bout de vos peines;
il reste un problème à régler. À ce stade, vous êtes capable
d'intégrer les changements que j'apporte à mon dépôt au
votre. Toutefois, il vous reste à configurer git de manière à ce que
vos modifications locales soient envoyées à votre dépôt. Pour ce faire,

1. Assurez-vous que RStudio soit bien ouvert à votre projet (coin
   supérieur droit) et que vous travailliez bien sur la branche
   «automne2020».

2. Dans le panneau supérieur droit, cliquez sur l'onglet `Git`. Cliquez
   sur le petit icône en forme d'engrenage dans la boîte d'outil puis
   sur `Shell...`.

![Screenshot, RStudio git open shell](readme_pictures/remotes3.png)

4. Dans la fenêtre qui vient de s'ouvrir, tapez la commande suivante
   (suivi de `enter`):

``` Shell
git config remote.origin.pushurl <URL de votre dépôt>
```
Vous pouvez trouver l'URL de votre dépôt en cliquant sur le bouton `Code`
situé au haut de la page de votre dépôt. Félicitation, vous êtes
maintenant prêt à suivre le cours!

### Triangular workflow.
Retournez voir le schéma du début de la section. Remarquez que vous
intégrez les changements d'un dépôt ne vous appartenant pas tandis que
vous modifiez un dépôt vous appartenant. Cette utilisation asymétrique
de Git est connue sous le nom de Triangular workflow. Sachez que si
l'envie vous prenait de contribuer à un projet libre ou open source un
jour, il s'agit généralement du workflow employé.

### Interagir avec les différents dépôts.
Tout au long du cours, vous aurez besoin d'accomplir trois opérations de base:
* Pull
* Commit
* Push

Il est possible d'effectuer ces trois opérations directement à partir
de RStudio.

#### `git pull`: incorporer les changements les plus récents.
La première opération à maîtriser est connue sous le nom de `git
pull`. Elle correspond à la flèche 1 sur le schéma du début de la
section. En réalité, elle accomplit deux tâches:
1. Importer les changements distants (équivaut à `git fetch`).
2. Incorporer ces changements à votre dépôt local (équivaut à `git merge`).

**Important**: *Avant de procéder à un `git pull` il est essentiel de
vous assurer que vos changements locaux ont été commis (voir section
suivante). Dans le cas contraire, vous aurez droit à un message
d'erreur de la part de git.*

Voici la marche à suivre pour procéder à un `git pull` à partir de
RStudio.
1. Sous l'onglet `Git`, dans la barre d'outils, cliquez sur
   `Pull`.

![Screenshot, pull button RStudio](readme_pictures/pull_button.png)

2. Si nécessaire, authentifiez-vous.
3. Une nouvelle fenêtre devrait s'ouvrir et donner une sortie
   semblable à celle illustrée ci-dessous.

![Screenshot, pull output RStudio](readme_pictures/pull_output.png)

#### `git commit`: commettre vos modifications locales.
Cette opération est *toujours* préalable à la troisième opération,
`git push`. Conceptuellement, elle est quelque peu
abstraite. Toutefois, elle est relativement facile à réaliser en
général.

Il n'est pas possible de soumettre directement des changements
apportés à votre dépôt local vers votre dépôt distant. La *seule*
manière de modifier le dépôt distant est de lui intégrer une sorte de
«photo» d'un changement ou d'un ensemble de changements locaux. Dans
le jargon de Git, ces photos sont appelées commits et sont générés par
la commande `git commit`. Voici comment procéder à partir de RStudio.
1. Sous l'onglet `Git`, dans la barre d'outils, cliquez sur le bouton
   `Commit`.

![Screenshot, commit button](readme_pictures/commit_toolbox.png)

2. Dans la nouvelle fenêtre, cochez les cases de la colonne `Staged`
   correspondant aux fichiers que vous souhaitez inclure dans votre
   commit. La colonne `Status` correspondante devrait afficher `A`
   (pour added).

![Screenshot, add to commit](readme_pictures/commit_tickbox.png)

3. Tapez une *courte* description dans la boîte `Commit message`.

4. Cliquez sur `Commit`.

![Screenshot, commit message](readme_pictures/commit_message.png)

5. Une nouvelle fenêtre devrait s'ouvrir et donner une sortie
   semblable à celle illustrée ci-dessous.

![Screenshot, commit output](readme_pictures/commit_output.png)

#### `git push`: envoyer vos commit vers votre dépôt distant.
Le `push` est l'opération qui consiste à envoyer vos commits vers
votre dépôt distant. Elle correspond à la flèche 2 dans le schéma du
début de la section. Pour la réaliser, sous l'onglet `Git`, dans la
barre d'outils, cliquez simplement sur `Push` et authentifiez-vous si
nécessaire.

![Screenshot, push button](readme_pictures/push_button.png)

Une nouvelle fenêtre devrait s'ouvrir et donner une sortie semblable à
celle illustrée ci-dessous.

![Screenshot, push output](readme_pictures/push_output.png)

## Pour en savoir plus.
Git est un logiciel immensément populaire pour lequel il existe une
quantité impressionnante de documentation et tutoriels. Si vous
rencontrez un problème ou que vous souhaitez en apprendre davantage,
je vous recommande vivement les liens suivants:
* https://happygitwithr.com/
* https://git-scm.com/doc
