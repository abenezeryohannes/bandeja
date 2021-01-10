import axios from 'axios'
export const store = {

    state: {
        loaded: false,
        boot_info : {

        },
        notifications: [],
        main_menu: [],
        permissions : [],
        toolbar_opened: true,
        my_account_opened: false
    },
    setNotifications(n){
        this.state.notifications = n
    },
    setPermissions(p){
            this.state.permissions = p
    },

    menuNormalState(){
      this.state.toolbar_opened = false
      this.state.my_account_opened = false
    },

    toggleToolbar(){
      this.state.toolbar_opened = !this.state.toolbar_opened
        // console.log(this.state.toolbar_opened)
    },
    toggleMyAccount(){
      this.state.my_account_opened = !this.state.my_account_opened
    },

    getPermissions(){
        if(this.state.permissions.length)
            return new Promise((resolve, reject) => { resolve(this.state.permissions) })
        else
            return new Promise((resolve, reject) => {
                axios
                    .get('/api/minja/boot')
                    .then(response => {
                        this.state.permissions = response.data.data.permissions
                        resolve(this.state.permissions)
                    })
                    .catch(error => {
                        reject();
                    })
            })
    }

}