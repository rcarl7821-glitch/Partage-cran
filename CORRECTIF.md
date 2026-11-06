# Pixel Local 2.0.1 — correctif de connexion

## Installer
1. Arrête le partage de la version précédente.
2. Installe Pixel-Local-2.0.1.apk sur le téléphone en choisissant Mettre à jour. Ne désinstalle pas : le certificat et le paquet sont conservés.
3. Relance le partage de l'écran entier.
4. Ferme les anciens onglets Pixel Local sur le PC. Ouvre de nouveau l'adresse de base, par exemple http://10.58.17.121:8080/ si elle est toujours valable, ou utilise le lanceur PC.
5. Actualise la page avec Ctrl+Maj+R avant de saisir le code. Le code change à chaque nouvelle capture. Si le navigateur était déjà mémorisé, il peut se connecter directement.

Le lanceur PC de la version 2.0 est inchangé et reste utilisable.

## Correctif technique
La version 2.0 rejetait tout en-tête Origin différent d'une chaîne exacte http://Host. Certains contextes de navigateur peuvent envoyer Origin: null, notamment avec une politique Referrer-Policy restrictive sur une soumission de formulaire HTTP. Le message observé prouve que le contrôle d'origine a rejeté la requête, sans révéler la valeur exacte envoyée.

Cette version ne supprime pas les protections :
- un jeton anti-CSRF aléatoire est obligatoire pour toutes les requêtes POST, connexion et contrôle compris ;
- un Origin explicite non nul doit toujours correspondre au protocole, à l'hôte et au port du téléphone ;
- un Origin absent ou opaque n'est accepté qu'avec le jeton anti-CSRF valide ;
- les pages utilisent maintenant Referrer-Policy: same-origin ;
- tous les messages textuels déclarent UTF-8 pour éviter les accents mal affichés ;
- les cookies HttpOnly/SameSite et l'authentification par code sont conservés.

Les fonctionnalités 2.0 restent inchangées : modes d'image, mémorisation du navigateur et contrôle facultatif par accessibilité. Le transport demeure HTTP local non chiffré par l'application : utiliser uniquement un point d'accès personnel sécurisé.

## Vérifications
Compilation Android, signature APK et syntaxe JavaScript vérifiées. Douze tests unitaires couvrent notamment l'origine normale, opaque et absente, les jetons invalides, les ports et hôtes différents. Ces tests ne remplacent pas un essai sur un vrai Pixel : celui-ci reste à effectuer.

Si le problème persiste, indiquer s'il survient après le code de connexion ou après une commande souris. Ne pas transmettre le code ou les cookies.
