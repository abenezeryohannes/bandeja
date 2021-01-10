<?php


namespace Modules\User\Services;


class Authorization
{
    private $user;
    private $permissions = [];
    private $roles = [];

    public function setUser($user)
    {
        $this->user = $user;
        $this->roles = $this->user->current_position->job_position->roles ?? [];
        $this->_add_permission();
    }

    private function _add_permission()
    {
        $permissions = collect([]);
        foreach ($this->roles as $role) {
            $p = RoleHasPermissions::get($role);
            $permissions = $permissions->merge($p);
        }
        $this->permissions = $permissions->toArray();
    }

    public function hasPermissions($permissions)
    {
        // dd($this->permissions, $permissions);
        foreach ($permissions as $permission) {
            $found = array_search($permission, $this->permissions);
            if ($found === false) {
                return false;
            }
        }
        return true;
    }

    public function hasRoles($roles)
    {
        foreach ($roles as $role) {
            $found = array_search($role, $this->roles);
            if ($found === false) {
                return false;
            }
        }
        return true;
    }

}