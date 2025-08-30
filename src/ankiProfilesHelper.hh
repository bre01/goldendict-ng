//
// Created by bre on 8/27/25.
//

#ifndef GOLDENDICT_NG_ANKIPROFILES_H
#define GOLDENDICT_NG_ANKIPROFILES_H
#include "config.hh"
#include <QWidget>



class ankiProfilesHelper {
private:
  //QVector<Config::AnkiProfile> _profiles;

public:

  explicit ankiProfilesHelper();
  QWidget *newFieldRowWidget(QString name, QString value);
};



#endif //GOLDENDICT_NG_ANKIPROFILES_H
