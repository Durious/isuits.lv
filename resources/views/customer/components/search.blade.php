<!-- search Popup -->
<div class="body-overlay" id="body-overlay"></div>
<div class="search-popup" id="search-popup">
    <form action="{{route('customer.products', 'all')}}" class="search-form" method="GET">
        <div class="form-group">
            <input type="text" class="form-control" placeholder="Search" onfocus="this.placeholder = ''"
                onblur="this.placeholder = 'Search Here'" name="search" required />
        </div>
        <button type="submit" class="submit-btn">
            <i class="fa fa-search"></i>
        </button>
    </form>
</div>
<!-- //. search Popup -->