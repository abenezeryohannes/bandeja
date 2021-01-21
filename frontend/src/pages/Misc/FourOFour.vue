<template>
    <div class="main-content" id="panel">
        <div id="main-body">
            <div id="header" class="header pb-6">
                <div class="container-fluid content-layout">
                    <div class="header-body">
                        <div class="row py-4 align-items-center">
                            <div class="col-xs-12 col-sm-4 col-md-5 align-items-center">
                                <h2 class="d-inline-flex mb-0 long-texts">Oops! Page not found</h2>
                            </div>
                            <div class="col-xs-12 col-sm-8 col-md-7">
                                <div class="text-right">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid content-layout mt--6">
                <div id="app">
                    <div class="card">
                        <div class="card-header">
                            <h2 class="mb-0 text-warning"><i class="fa fa-exclamation-triangle text-warning"></i>&nbsp;&nbsp;404 Not Found</h2>
                        </div>
                        <div class="card-body">
                            <p>We could not find the page you were looking for.</p>
                            <router-link  :to="{ name : 'Invoices' }"  class="btn btn-success header-button-top"><span class="fa fa-tachometer-alt"></span> &nbsp;Go to dashboard</router-link>
                        </div>
                    </div>
                    <notifications></notifications>
                    <form id="form-dynamic-component" method="POST" action="#"></form>
                    <component v-bind:is="component"></component>
                </div>
                <footer class="footer">
                    <div class="row">
                        <div class="col-xs-12 col-sm-6">
                            <div class="text-sm float-left text-muted footer-texts">
                                Developed By: <a href="https://melfantech.com" target="_blank" class="text-muted">Melfan Tech</a>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="text-sm float-right text-muted footer-texts">
                                Version 1.0.0
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
    </div>
</template>
