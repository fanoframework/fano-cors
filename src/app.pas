(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
program app;

uses

    fano,
    bootstrap;

var
    appInstance : IWebApplication;

begin
    writeln('Starting application at 127.0.0.1:20477');

    (*!-----------------------------------------------
     * Bootstrap SCGI application
     *
     * @author AUTHOR_NAME <author@email.tld>
     *------------------------------------------------*)
    appInstance := TDaemonWebApplication.create(
        TScgiAppServiceProvider.create(
            TServerAppServiceProvider.create(
                TAppServiceProvider.create(),
                (TInetSvrFactory.create('127.0.0.1', 20477) as ISocketSvrFactory).build()
            )
        ),
        TAppRoutes.create()
    );
    appInstance.run();
end.
