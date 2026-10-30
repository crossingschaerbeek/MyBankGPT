# MON FINANCE — V1.0

## État
Prototype fonctionnel à déployer : connexion privée Supabase Auth, comptes multiples, revenus et dépenses manuels, dettes et urgences, tableau de bord, interface responsive.

**Non implémenté :** synchronisation bancaire réelle (PSD2), transferts entre comptes, rapprochement, récurrences, historique des remboursements, simulation des intérêts, alertes automatiques, prévisions calendaires, export et édition/suppression. Ne pas utiliser comme comptabilité de référence sans vérification. Les dettes ne sont pas automatiquement diminuées lors de l'enregistrement d'une dépense.

## Installation
1. Créer un projet Supabase privé et exécuter `supabase/schema.sql` dans SQL Editor (sur une base neuve).
2. Dans Supabase Auth > Providers > Email, désactiver les inscriptions publiques. Créer/inviter manuellement le compte utilisateur, puis définir son mot de passe par le flux sécurisé Supabase. Activer MFA dans Supabase si disponible et souhaité.
3. Copier `.env.example` vers `.env.local` et renseigner URL et clé publique (anon/publishable) Supabase. **Ne jamais utiliser la clé service_role dans NEXT_PUBLIC_**.
4. `npm install` puis `npm run dev`.
5. Pousser le dossier dans un dépôt Git privé, l'importer dans Vercel, définir les deux variables d'environnement, déployer.
6. Tester login, séparation des données, insertion, mobile et déconnexion avant d'ajouter des données sensibles.

## Sécurité / production
Le RLS filtre les données par utilisateur. La création de compte est désactivée côté application. Pour un usage réel, configurer MFA, politiques de mot de passe, sauvegardes, journalisation et supervision. La configuration des cookies SSR et le routage doivent être revus/testés sur le domaine de production. Ne pas saisir de mot de passe bancaire dans cette application.

## Synchronisation bancaire — étape future
Choisir un prestataire open banking autorisé selon pays et banques, mettre en place consentement OAuth, stockage chiffré des tokens côté serveur, renouvellement, webhooks, déduplication et révocation. La V1 ne contient pas de connecteur bancaire.
