import Vue from 'vue'






Vue.component('layout-a',
	require('./src/layouts/LayoutA.vue').default);

Vue.component('layout-b',
	require('./src/layouts/LayoutB.vue').default);



Vue.component('k-tab',
	require('./the-office/KTab').default);

Vue.component('k-table',
	require('./the-office/KTable.vue').default);

Vue.component('k-table2',
	require('./the-office/KTable2.vue').default);

Vue.component('k-add-item',
	require('./the-office/KAddItem.vue').default);


Vue.component('avatar-mgt',
	require('./the-office/AvatarMgt.vue').default);

Vue.component('several-actions',
	require('./the-office/SeveralActions.vue').default);

Vue.component('k-view-edit',
	require('./the-office/KViewEdit.vue').default);

// Vue.component('calendar-box',
// 	require('./common/Calendar.vue').default);
// Vue.component('k-tab',
// 	require('./common/low/KTab').default);


// Vue.component('k-table',
// 	require('./common/KTable.vue').default);