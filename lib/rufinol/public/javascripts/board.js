function updatePin(pin) {
  var pinRow = $("#" + pin.pin_type + "_" + pin.pin_number);
  $("div[data-pin-field=value]", pinRow).html(pin.value.toString());

}