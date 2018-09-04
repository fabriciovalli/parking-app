import 'package:app4car/redux/search/search_actions.dart';

String searchQueryReducer(String searchQuery, dynamic action) {
  if (action is SearchQueryChangedAction) {
    return action.query;
  }

  return searchQuery;
}
