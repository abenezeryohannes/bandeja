<?php


namespace Modules\User\Services;


class RoleHasPermissions
{

    private static $roles = [
        'ADMIN' => [
            'permissions' => [
                'HR.INDEX',
                'MEMBERS.INDEX',
                'EVENTS.INDEX',
                'FINANCE.INDEX',
                'PLAN.INDEX',
                'INVENTORY.INDEX',
                'MESSAGE.INDEX',
                'TODO.INDEX'
            ]
        ],
        'FINANCE' => [
            'permissions' => [
                'FINANCE.INDEX',
                'MESSAGE.INDEX',
                'TODO.INDEX'
            ]
        ],
        'EMPLOYEE' => [
            'permissions' => [
                'MESSAGE.INDEX',
                'TODO.INDEX'
            ]
        ],

    ];

    private static $authority_roles = [
        'DEPARTMENT_LEADER' => [
            'permissions' => [
                'PLAN.*'
            ]
        ],

    ];


    public static function get($role)
    {
        $role = strtoupper($role);
        return self::$roles[$role]['permissions'] ?? [];
    }

    public static function roles()
    {

        $roles = self::$roles;
        return array_keys($roles);
    }

}