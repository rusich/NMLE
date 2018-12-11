#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QuickQanava>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("NiMod Logic Editor");
    QGuiApplication::setOrganizationName("rusich");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
//    qputenv("QT_SCALE_FACTOR", "0.7");
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QuickQanava::initialize(&engine);
    engine.load(QUrl(QStringLiteral("qrc:/themetest.qml")));
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
