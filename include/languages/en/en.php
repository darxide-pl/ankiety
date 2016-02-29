<?php

define('TM_CUSTOMERS', 'Klienci');

define('L_LOGIN_SUCCESS', 'Logowanie do systemu zakończyło się powodzeniem.');
define('L_LOGIN_BLOCKED_ACCOUNT', 'Twoje konto zostało zablokowane lub nie zostało jeszcze aktywowane. Nie możesz się zalogować.');
define('L_LOGIN_INCORECT_DATA','Podano nieprawidłowy login i/lub hasło. Prosimy spróbować ponownie.');
define('L_LOGIN_LOGED','Już jesteś zalogowany, nie możesz zrobić tego ponownie.');
define('L_LOGIN_LOGOUT_SUCCESS', 'Wylogowano Cię z systemu.');

define('L_PAGE_DONT_EXISTS','Przyko nam ale strona której szukasz nie została odnaleziona.');
define('L_PAGE_NOT_AUTHENTICATED','Niestety ale strona nie została jeszcze udostępniona publicznie, zapraszamy wkrótce.');
define('L_PAGE_ACTION_REFRESH', 'Żadana akcja nie mogła zostać wykonana. Możliwe, że próbujesz wykonać tą samą akcję więcej niż raz.');

define('L_AUTH_NO_RIGHTS', 'Strona której szukasz jest dostępna tylko dla autoryzowanych użytkowników. Zaloguj się aby uzyskać do niej dostęp.');

define('L_DB_CONNECTION_ERROR', 'Błąd: Połączenie z bazą danych nie powiodło się.<br />Treść błędu: '.DB::Instance()->ConnectError());

define('L_SESSION_DONT_EXISTS', 'Sesja została utracona lub nigdy nie istaniała. Prawdopodobnie zbyt długo nie wykonywano żadnych operacji na stronie i dla bezpieczeństwa sesja uległa przedawnieniu. Prosimy zalogować się ponownie.');

define('TPL_MAIN_LOGED_IN', 'Zalogowany:');
define('TPL_MAIN_LOGOUT_BUTTON', 'Wyloguj się');
define('TPL_MAIN_LANGUAGE_POLISH', 'Polski');
define('TPL_MAIN_LANGUAGE_ENGLISH', 'Angielski');

define('TM_MAIN_PAGE', 'Strona główna');
define('TM_ORDERS', 'Zamówienia');
define('TM_PRODUCTS', 'Produkty');
define('TM_USERS', 'Użytkownicy');
define('TM_USERS_GROUPS', 'Grupy');
define('TM_CONFIG', 'Konfiguracja');
define('TM_CFG_GROUPS', 'Grupy opcji');
define('TM_SYS_ACTIONS', 'Akcje');
define('TM_SYS_MSG', 'Powiadomienia');
define('TM_POSTAGE', 'Formy dostawy');
define('TM_PAYMENT', 'Formy płatności');
define('TM_CUSTOMERS', 'Klienci');
define('TM_PRODUCT_ARRAYS', 'Zestawy');
define('TM_ARTICLES', 'Artykuły');
define('TM_ARTICLES_CATEGORIES','Kategorie artykułów');
define('TM_NEWSLETTER', 'Newsletter');
define('TM_NEWSLETTER_USERS', 'Baza adresów email');

define('TPL_LIST_RECORDS_ON_PAGE', 'Na stronie:');
define('TPL_LIST_ALL_RECORDS', 'Wszystkich:');
define('TPL_LIST_NAV_PAGE','Strona: ');
define('TPL_LIST_NAV_FROM','z');

define('TPL_LOGIN_TITLE', 'Logowanie');
define('TPL_LOGIN_PASS_RENEW', 'Przypomnienie hasła');
define('TPL_LOGIN_ADMIN_MSG', 'Kontakt z administratorem');
define('TPL_LOGIN_B_LOGIN', 'Zaloguj');

define('TPL_LIST_STATS', 'Wyświelono: <b>%s</b> ( %s - %s ) z %s');

define('TFB_ADD', 'Zapisz');
define('TFB_UPDATE', 'Zapisz zmiany');
define('TFB_SAVE', 'Zapisz');
define('TFB_CANCEL', 'Anuluj');
define('TFB_APPLY', 'Zastosuj');
define('TF_DELETE_BUTTON', 'Usuń');
define('TF_EDIT_BUTTON', 'Edytuj');

define('T_SEL_OPT_ALL', ' [ wszyscy ] ');
define('T_SEL_OPT_ALL1', ' [ wszystkie ] ');
define('T_SEL_OPT_ALL2', ' [ wszystko ] ');

define('T_YES', 'Tak');
define('T_NO', 'Nie');

define('T_CMENU_TITLE', 'Menu kontekstowe');
define('T_CMENU_OPT', 'Opcje');

define('TDB_QUERY_ERROR', 'Błąd zapytania do bazy danych.');

define('TASE_WOBJECT', 'Nie powiodło się zbieranie informacji o obiekcie.');
define('TASE_CANT_SAVE', 'Nie udało się zapisać danych. '.TASE_WOBJECT);
define('TASE_WOBJECT2', 'Nie udało się usunąć obiektu %s. '.TASE_WOBJECT);
define('TASE_NO_TABLE', 'Nie podano nazwy tabeli %s.');

define('TFBOX_ACTIVE_FILTERS', '<i>Aktywne filtry:</i>');
define('TFBOX_BUTT_REMOVE_FILTERS', 'wyczyść filtry');
define('TFBOX_BUTT_UPDATE_FILTERS', 'Filtruj');
define('TFBOX_BUTT_CLEAR_FILTERS', 'Wyczyść filtry');
define('TFBOX_BUTT_FILTERS_TITLE', 'Filtry');