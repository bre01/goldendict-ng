//
// Created by bre on 8/27/25.
//
#pragma once

#include "config.hh"
#include "preferences.hh"

#include <QWidget>
#include <QTabWidget>
#include <QVector>



class AnkiProfilesHelper:QObject {
  Q_OBJECT
  QTabWidget* tabWidget;

public:

  AnkiProfilesHelper(QTabWidget* tab);int createTabsFromProfiles(QVector<Config::AnkiProfile>profiles);
  QWidget*newEditEditWidget(QString name, QString value);
  QWidget *newLabelEditWidget(QString name, QString value);
  bool setPreferences(Config::Preferences&p);
public slots:
  void createNewTab(QString profileName);


};



