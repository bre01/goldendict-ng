//
// Created by bre on 8/27/25.
//

#include "ankiProfilesHelper.hh"

#include <QHBoxLayout>
#include <QLabel>
#include <QLineEdit>
#include <QWidget>

 ankiProfilesHelper::ankiProfilesHelper()
//  _profiles(profiles)
{
}
QWidget* ankiProfilesHelper::newFieldRowWidget(QString name,QString value)
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

/*
tabs ankiProfilesHelper::profilesAsTabs()
 {

 }
 */
