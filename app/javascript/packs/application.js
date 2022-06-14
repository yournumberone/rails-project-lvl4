// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
import '@fortawesome/fontawesome-free/css/all';
import 'bootstrap';

// Import the specific modules you may need (Modal, Alert, etc)
import { Tooltip, Popover } from 'bootstrap';

require('@popperjs/core');

// The stylesheet location we created earlier
require('../stylesheets/application.scss');


// If you're using Turbolinks. Otherwise simply use: jQuery(function () {
document.addEventListener('turbolinks:load', () => {
  // Both of these are from the Bootstrap 5 docs
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
  const tooltipList = tooltipTriggerList.map((tooltipTriggerEl) => new Tooltip(tooltipTriggerEl));

  const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
  const popoverList = popoverTriggerList.map((popoverTriggerEl) => new Popover(popoverTriggerEl));
});

Rails.start();
Turbolinks.start();
ActiveStorage.start();
