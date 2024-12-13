global class WebSpeechApiPicklist extends VisualEditor.DynamicPickList {
    global override VisualEditor.DataRow getDefaultValue() {
      VisualEditor.DataRow defaultValue = new VisualEditor.DataRow(
        System.Label.ChatBotSpeechLanguage,
        System.Label.ChatBotSpeechLanguageCode
      );
      return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
      Map<String, String> languages = new Map<String, String>{
        System.Label.ChatBotSpeechLanguage => System.Label.ChatBotSpeechLanguageCode
      };
  
      VisualEditor.DynamicPickListRows languagePicklist = new VisualEditor.DynamicPickListRows();
      for (String langKey : languages.keySet()) {
        languagePicklist.addRow(
          new VisualEditor.DataRow(langKey, languages.get(langKey))
        );
      }
      return languagePicklist;
    }
  }