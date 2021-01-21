import Vue from 'vue'






Vue.component('layout-a',
	require('./src/layouts/LayoutA.vue').default);

Vue.component('layout-b',
	require('./src/layouts/LayoutB.vue').default);



Vue.component('ak-switcher',
	require('./akaunting-ui/form/element/Switcher.vue').default);
Vue.component('ak-input',
	require('./akaunting-ui/form/element/Input.vue').default);
Vue.component('ak-select',
	require('./akaunting-ui/form/element/Select.vue').default);
Vue.component('ak-file',
	require('./akaunting-ui/form/element/File.vue').default);
Vue.component('ak-textarea',
	require('./akaunting-ui/form/element/Textarea.vue').default);
Vue.component('ak-blank',
	require('./akaunting-ui/form/element/Blank.vue').default);

Vue.component('ak-form-a',
	require('./akaunting-ui/form/FormA.vue').default);


Vue.component('ak-table',
	require('./akaunting-ui/table/Table.vue').default);
Vue.component('ak-actions',
	require('./akaunting-ui/button/ActionButton.vue').default);
Vue.component('ak-dropup',
	require('./akaunting-ui/button/DropupButton.vue').default);
