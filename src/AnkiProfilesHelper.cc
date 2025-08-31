//
// Created by bre on 8/27/25.
//

#include "AnkiProfilesHelper.hh"
#include <QHBoxLayout>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QTabWidget>
#include <QWidget>
#include<QVector>
#include "config.hh"

AnkiProfilesHelper::AnkiProfilesHelper(QTabWidget* tab):
  tabWidget(tab)
 {

 }
int AnkiProfilesHelper::createTabsFromProfiles(QVector<Config::AnkiProfile> profiles)
 {
   QWidget* widget;
   QVBoxLayout* layout;

   for (auto &profile :profiles) {
     //QPushButton *addButton=new QPushButton("add profile");
     //connect(addButton,&QPushButton::clicked,this,[](){});
     widget = new QWidget();
     layout = new QVBoxLayout(widget);
     layout->addWidget(newLabelEditWidget("host",profile.host));
     layout->addWidget(newLabelEditWidget( "port",QString::number(profile.port )));
     layout->addWidget( newLabelEditWidget( "deck",profile.deck ));
     layout->addWidget( newLabelEditWidget( "model",profile.model));




     QHBoxLayout* hbox = new QHBoxLayout();
     QPushButton* newFieldButton=new QPushButton("New field");
     hbox->addWidget(newFieldButton);

     connect(newFieldButton,&QPushButton::clicked,this,[this,layout]() {
         layout->addWidget(newEditEditWidget("enter new field","enter new value"));
     });


     QPushButton* deleteFieldButton=new QPushButton("last field");
     hbox->addWidget(deleteFieldButton);
     layout->addLayout(hbox);
     connect(deleteFieldButton,&QPushButton::clicked,this,[this,layout]() {
        if (layout->count()>=5) {
          layout->removeItem( layout->itemAt( layout->count()-1 ) );
        }
     });

     for (auto [key,value]:profile.fields.asKeyValueRange()) {
       layout->addWidget( newEditEditWidget(key,value));
     }
     tabWidget->addTab( widget,profile.name );
     //layout->addWidget(addButton);
     //break;
   }
    return profiles.count();
 }




QWidget* AnkiProfilesHelper::newEditEditWidget(QString name,QString value)
 {
   QWidget *rowWidget=new QWidget();
   QHBoxLayout *rowLayout=new QHBoxLayout(rowWidget);
   QLineEdit *nameLineEdit=new QLineEdit();
   QLineEdit *valueLineEdit=new QLineEdit();
   nameLineEdit->setText( name);
   valueLineEdit->setText( value );
   rowLayout->addWidget( nameLineEdit);
   rowLayout->addWidget( valueLineEdit);
   return rowWidget;
 }

QWidget* AnkiProfilesHelper::newLabelEditWidget(QString name,QString value)
 {
   QWidget *rowWidget=new QWidget();
   QHBoxLayout *rowLayout=new QHBoxLayout(rowWidget);
   QLabel *label=new QLabel(name);
   QLineEdit *lineEdit=new QLineEdit();
   lineEdit->setText( value );
   rowLayout->addWidget( label );
   rowLayout->addWidget( lineEdit );
   return rowWidget;
 }

bool AnkiProfilesHelper::setPreferences(Config::Preferences &p)
{
   QWidget* widget=tabWidget->currentWidget();
   QVBoxLayout* layout = qobject_cast<QVBoxLayout*>(widget->layout());
   QHBoxLayout* hboxlayout;
   if (layout) {
     p.ankiConnectServer.host  = qobject_cast<QLineEdit*>(qobject_cast<QHBoxLayout* >(layout->itemAt(0)->layout())->itemAt(1)->widget() )->text();
     p.ankiConnectServer.port  = qobject_cast<QLineEdit*>(qobject_cast<QHBoxLayout* >(layout->itemAt(1)->layout())->itemAt(1)->widget() )->text().toInt();
     p.ankiConnectServer.deck  = qobject_cast<QLineEdit*>(qobject_cast<QHBoxLayout* >(layout->itemAt(2)->layout())->itemAt(1)->widget() )->text();
     p.ankiConnectServer.model  = qobject_cast<QLineEdit*>(qobject_cast<QHBoxLayout* >(layout->itemAt(3)->layout())->itemAt(1)->widget() )->text();
     QString name,value;
     p.ankiConnectServer.fields.clear();
     //the widget indexed 5 is the add field button
     for (int i=5;i<layout->count();++i) {
       hboxlayout=qobject_cast<QHBoxLayout*>(layout->itemAt(i)->layout());
       p.ankiConnectServer.fields[qobject_cast<QLineEdit*>(hboxlayout->itemAt( 0 )->widget())->text()]=qobject_cast<QLineEdit*>(hboxlayout->itemAt( 1 )->widget())->text();
       //value=layout->itemAt( i )->widget()->findChild<QLineEdit*>(  )->text();
       //p.ankiConnectServer.fields[name]=value;
     }
   }

 }
void AnkiProfilesHelper::createNewTab(QString profileName)
{
  QWidget* widget;
  QVBoxLayout* layout;
  widget = new QWidget();
  layout = new QVBoxLayout(widget);
  layout->addWidget(newLabelEditWidget("host","enter host"));
  layout->addWidget(newLabelEditWidget( "port","9999"));
  layout->addWidget( newLabelEditWidget( "deck","enter deck"));
  layout->addWidget( newLabelEditWidget( "model","enter model"));
  QPushButton* newFieldButton=new QPushButton("New field");
  layout->addWidget(newFieldButton);
  connect(newFieldButton,&QPushButton::clicked,this,[this,layout]() {
      layout->addWidget(newEditEditWidget("enter new field","enter new value"));
  });
  /*
  for (auto [key,value]:profile.fields.asKeyValueRange()) {
    layout->addWidget( newEditEditWidget(key,value));
  }
  */
  tabWidget->addTab(widget,profileName );
  //layout->addWidget(addButton);
  //break;


}



/*
tabs ankiProfilesHelper::profilesAsTabs()
 {

 }
 */
