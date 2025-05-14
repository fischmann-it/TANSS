🔌 3CX Serverside CRM Integration für TANSS (MySQL)

📌 Warum brauche ich das?

Durch eine serverseitige Integration kann 3CX bei eingehenden Anrufen auf die TANSS-Datenbank zugreifen und automatisch den Namen und das Unternehmen des Anrufers anzeigen. Zusätzlich erhält der Agent einen Button, um den Kontakt direkt in TANSS zu öffnen.

⸻

⚙️ Einstellungen in TANSS
	•	Es sind keine Änderungen in TANSS selbst nötig.
	•	Du benötigst:
	•	Einen read-only MySQL-Benutzer
	•	Eine Freischaltung der 3CX-IP-Adresse in der Firewall
	•	Optional: Du kannst in MySQL eine View erstellen, um die Daten einheitlich aufzubereiten (z. B. für Estos oder direkt für 3CX).

⸻

⚙️ Einstellungen in 3CX
	1.	Gehe zu: Einstellungen → CRM → Neu → Datenbank → MySQL
	2.	Trage deine TANSS-Datenbank-Zugangsdaten ein
	•	Datenbankserver: dein.db.server:3306
	•	Datenbankname, Benutzername und Passwort
	3.	SQL Statements:
	•	Für “Lookup by Number SQL Statement” verwende das angepasste Statement aus der Datei 3cx_phone_lookup.sql (MySQL-kompatibel, angepasst auf TANSS)
	•	Ersetze +49 ggf. mit deiner Landesvorwahl
	•	Für “Search Contacts SQL Statement” verwende 3cx_search_contacts.sql (ebenfalls angepasst)
	4.	Contact URL Prefix (für TANSS):
	•	Beispiel: https://tanss.de/ansprechpartner/edit/?id=
	•	Dadurch erscheint in 3CX ein Button, der den Ansprechpartner in TANSS öffnet.
	5.	Alle anderen Felder leer lassen
	6.	Speichern

⸻

📲 Und jetzt?

Wenn ein Kunde anruft und seine Nummer einem Ansprechpartner in TANSS zugeordnet ist, zeigt 3CX automatisch:
	•	Name und Firma des Anrufers
	•	Einen Button zur direkten Öffnung des Kontakts in TANSS

⸻

⚠️ Hinweise
	•	Länge der SQL-Statements: 3CX begrenzt die maximale Länge der SQL-Abfragen. Achte auf möglichst kompakte Statements.
	•	Telefonnummernformatierung: Die Telefonnummern in TANSS sollten konsistent formatiert und z. B. in E.164 (+49…) überführt werden.

⸻

📚 Weiterführende Links
	•	3CX-Doku zu SQL-basierten Integrationen:
👉 https://www.3cx.com/docs/sql-database-pbx-integration/
