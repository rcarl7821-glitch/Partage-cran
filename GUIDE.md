# Pixel Local 2.0

## Installation — une fois
1. Arrête le partage de l'ancienne version.
2. Installe `Pixel-Local-2.0.apk` sur ton Pixel : Android devrait proposer **Mettre à jour**. Le paquet et le certificat sont les mêmes que dans les versions précédentes. Il n'est normalement pas nécessaire de désinstaller.
3. Sur le PC, extrais tout le ZIP dans un dossier. Garde `OUVRIR-PIXEL.bat` et `Ouvrir-Pixel.ps1` ensemble. Tu peux créer un raccourci du BAT sur le Bureau.

L'APK est signé avec le certificat de développement de ce projet. Ce n'est pas une application publiée ou vérifiée par le Play Store. Ne désactive pas Play Protect ni les protections du lycée si quelque chose est bloqué.

## Connexion simplifiée
1. Active le point d'accès Wi-Fi du Pixel et connecte le PC à ce réseau.
2. Sur le Pixel, ouvre **Pixel Local → Partager mon écran** et accepte **l'écran entier** dans la confirmation Android.
3. Sur le PC, double-clique sur **OUVRIR-PIXEL.bat**. Le lanceur cherche l'application sur les passerelles réseau, en privilégiant les interfaces Wi-Fi identifiables, puis ouvre le navigateur par défaut. Il teste seulement ces passerelles, sans balayage du réseau.
4. À la première connexion, saisis le **code à 6 chiffres** affiché sur le téléphone.
5. Si le PC et son profil navigateur sont bien personnels, coche **Mémoriser ce navigateur pendant 30 jours**.

Les prochaines fois, l'autorisation de capture sur le téléphone reste nécessaire. Le même navigateur et profil pourront accéder au flux sans ressaisir le code tant que le cookie et l'association sont valides. La mémorisation est liée à l'adresse IP du téléphone ; si cette adresse change, un nouvel appairage peut être nécessaire. La clé côté téléphone est renouvelée au plus tard après 30 jours lors d'un démarrage du partage ; une mémorisation peut donc expirer avant les 30 jours du cookie.

**Un PC du lycée peut être personnel ou partagé : ne mémorise pas l'accès si d'autres personnes utilisent ton profil Windows ou Chrome.**

### Si le lanceur ne marche pas
Ouvre directement dans Chrome l'adresse affichée sur le Pixel, par exemple `http://10.58.17.121:8080/` si elle est toujours valable. Aucune longue clé à saisir.

Le script PowerShell est lisible. Il utilise Get-NetIPConfiguration et Invoke-WebRequest, puis ouvre le navigateur ; il ne modifie pas le réseau, le pare-feu ou les droits administrateur. Le BAT utilise ExecutionPolicy Bypass pour son processus PowerShell uniquement, sans changer de stratégie persistante. Cela ne contourne pas AppLocker ni les restrictions d'entreprise. Si le lycée bloque le script, demander une autorisation ou utiliser l'adresse dans le navigateur ; ne pas désactiver les protections.

## Plus de fluidité
Deux réglages sur le téléphone, appliqués au démarrage du partage :
- **Fluide**, par défaut : petit côté de l'image limité à 540 pixels, qualité JPEG réduite et cible d'environ **30 images/s**.
- **Net** : petit côté limité à 720 pixels, meilleure qualité et cible d'environ **16 images/s**.

Il s'agit de cibles, pas de cadences garanties. Le compteur mesure les images capturées et encodées sur le téléphone, pas les images effectivement affichées dans Chrome. Si l'écran est statique, Android peut produire moins d'images ; batterie, chauffe, réseau et capture influencent les résultats. Les images Bitmap sont réutilisées pour limiter les allocations mémoire. Toujours pas de son.

## Contrôler depuis le PC — facultatif
L'affichage fonctionne sans cette autorisation.

### À configurer sur le téléphone
1. Dans Pixel Local, touche **Configurer l'accessibilité Pixel Local**.
2. Dans les réglages Android, trouve **Pixel Local — contrôle facultatif** et active son service si tu fais confiance à l'application.
3. Reviens dans Pixel Local, démarre le partage d'écran entier s'il n'est pas déjà actif.
4. Active **Autoriser le contrôle pour cette session**.
5. Dans la page du PC, clique sur **Activer la souris**.

**Cette autorisation est puissante :** elle permet au service d'effectuer des gestes et des actions globales sur le téléphone. Cette version ne demande pas la lecture du contenu des fenêtres d'accessibilité et n'enregistre pas les frappes. La capture d'écran donne néanmoins accès à ce qui est visible. N'accorde l'autorisation que sur ton propre téléphone, avec un PC de confiance. Le service d'accessibilité reste activé dans les réglages Android jusqu'à sa désactivation manuelle, mais le contrôle applicatif est coupé à l'arrêt du partage et doit être réautorisé pour la session suivante.

Android peut bloquer l'activation d'un service sensible installé hors boutique. Sur certaines versions, l'autorisation spécifique se trouve dans **Paramètres → Applications → Pixel Local → menu ⋮ → Autoriser les paramètres restreints**. N'accorde cette exception que si elle est proposée par Android pour ton téléphone personnel et si tu acceptes le risque. Ne désactive aucune protection globale ; si cette option n'est pas disponible, conserve l'affichage sans contrôle. La procédure dépend de ta version Android.

### Commandes disponibles
- Clic sur l'image : toucher l'écran.
- Cliquer-glisser : effectuer un balayage.
- Boutons **Retour**, **Accueil**, **Applications**.
- Le bouton **Activer/Désactiver la souris** du navigateur ajoute un second verrou local.

### Limites du contrôle
- Aucun accès root ou débogage nécessaire.
- Pas de clavier PC, copier-coller, pincement multitouch ni appui long dans cette version. Le clavier Android peut être utilisé en cliquant ses touches, avec une latence possible.
- Pas de contournement du code de verrouillage, des confirmations de sécurité ou des applis protégées.
- Utilise la capture de l'écran entier. Les coordonnées ne sont pas adaptées à la capture d'une seule application.
- Après une rotation du téléphone, le contrôle tactile est bloqué si le format change : arrêter puis relancer la capture dans l'orientation souhaitée.
- Des gestes peuvent être refusés par Android ou une application ; le message OK signifie que la commande a été acceptée par notre service, pas que l'action a réussi à l'écran.

## Révoquer et arrêter
- **Arrêter le partage**, sur le téléphone ou sa notification, coupe le flux et désactive le contrôle applicatif. Fermer l'onglet ne suffit pas.
- **Déconnecter ce navigateur**, sur la page PC, supprime son cookie d'appairage.
- **Oublier tous les PC associés**, dans Pixel Local, renouvelle la clé, coupe les anciens flux et impose un nouveau code à tous les navigateurs. Le contrôle est désactivé.
- Pour supprimer entièrement le service de contrôle, désactive-le dans les réglages d'accessibilité Android.

## Sécurité et données
- Tout passe directement par le réseau local ; aucun compte, publicité, relais Internet ni télémétrie intégrée.
- HTTP non chiffré par l'application : le cookie d'accès et le flux ne bénéficient pas d'un chiffrement TLS. Utilise uniquement ton point d'accès personnel protégé WPA2/WPA3 et ne partage pas son mot de passe.
- Le cookie est HttpOnly et SameSite=Strict. Les commandes utilisent POST et une vérification de l'origine si le navigateur la fournit. Cela ne remplace pas le chiffrement du transport.
- Code aléatoire à 6 chiffres, 5 tentatives maximum par fenêtre de 30 secondes, communes à tous les clients.
- Ne pas exposer le port 8080 sur Internet. Pas de redirection de port nécessaire.
- L'application ne stocke pas les captures sur disque. Le PC peut toujours photographier ou enregistrer l'écran. Active Ne pas déranger pour limiter l'exposition des notifications.
- Le PC peut consommer ton forfait pour ses propres téléchargements : configure ce Wi-Fi comme connexion limitée dans Windows.

## État des tests
Compilation Java/Android et signature APK vérifiées. Même certificat que la version précédente. Syntaxe JavaScript vérifiée et présence des pages/ressources dans l'APK contrôlée. **Pas de test sur Pixel physique ni de mesure réelle de fluidité ou de validation fonctionnelle du contrôle.** Cette version est un prototype à tester sur ton matériel.

## Si cela bloque
- Si la page de connexion s'affiche : le réseau fonctionne.
- Si Connexion refusée apparaît : vérifier le partage actif sur le Pixel et l'adresse du point d'accès ; ne pas désactiver le pare-feu.
- Si le code est refusé : utiliser les 6 chiffres de la session actuelle.
- Si l'image marche mais pas les clics : vérifier le service d'accessibilité, l'interrupteur de contrôle sur le Pixel et le bouton souris sur le PC.
- Si l'écran reste noir dans une application protégée : il n'y a pas de contournement prévu.
- Si un problème persiste, transmettre le message exact et la cadence affichée, sans montrer le code d'accès.
