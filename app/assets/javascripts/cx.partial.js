var Cx = Cx || {};

Cx.partial = {
  render: function(template, hash) {
    var s = template;
    $.each(hash, function(k,v) { s = s.replace(new RegExp('{{' + k + '}}','g'),v); });
    return s;
  }
}
