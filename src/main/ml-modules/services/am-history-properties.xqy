xquery version "1.0-ml";

module namespace resource = "http://marklogic.com/rest-api/resource/am-history-properties";

import module namespace history = "http://marklogic.com/agile-mastering/auditing/history"
  at "/ext/com.marklogic.agile-mastering/auditing/history.xqy";

declare function get(
  $context as map:map,
  $params  as map:map
  ) as document-node()*
{
  let $results := history:property-history(map:get($params,"uri"),  map:get($params,"property"))
  let $accept-types := map:get($context,"accept-types")
  return
    if ($accept-types = "application/json") then (
      xdmp:to-json($results)
    ) else
      document {
        $results
      }
};