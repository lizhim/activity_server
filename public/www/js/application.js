var myModule = angular.module('myApp', ['mobile-navigate']);

myModule.run(function ($route, $http, $templateCache) {
    angular.forEach($route.routes, function (r) {
        if (r.templateUrl) {
            $http.get(r.templateUrl, {cache: $templateCache});
        }
    });
});

myModule.controller('MainCtrl', function ($scope, $navigate) {
    $scope.$navigate = $navigate;
});

myModule.directive('ngTap', function () {
    var isTouchDevice = !!("ontouchstart" in window);
    return function (scope, elm, attrs) {
        if (isTouchDevice) {
            var tapping = false;
            elm.bind('touchstart', function () {
                tapping = true;
            });
            elm.bind('touchmove', function () {
                tapping = false;
            });
            elm.bind('touchend', function () {
                tapping && scope.$apply(attrs.ngTap);
            });
        } else {
            elm.bind('click', function () {
                scope.$apply(attrs.ngTap);
            });
        }
    };
});


var native_access;
$(document).ready(function () {
    localStorage.getItem("activity") == null ? localStorage.setItem("activity", JSON.stringify([])) : true;
    localStorage.getItem("price_count_array") == null ? localStorage.setItem("price_count_array", JSON.stringify([]))
        : true;

    native_access = new NativeAccess();

});
function go_to_act_detail_page_by_name_of(act_name) {
    var page_jump_or_not = document.getElementById(act_name)
    if (page_jump_or_not) {
        var scope = angular.element(page_jump_or_not).scope();
        scope.$apply(function () {
            scope.date_refresh();
        })
    }
}