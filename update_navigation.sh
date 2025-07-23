#!/bin/bash

# New navigation structure
NEW_NAV='    <!-- Navigation -->
    <nav class="main-nav">
        <div class="nav-container">
            <div class="logo">
                <a href="index.html">
                    <img src="assets/images/ww-logo-pink.png" alt="WonderWomen" class="nav-logo">
                </a>
            </div>
            
            <ul class="nav-menu">
                <li class="nav-item dropdown">
                    <a href="about/our-mission.html" class="nav-link">About Us</a>
                    <ul class="dropdown-menu">
                        <li><a href="about/our-mission.html">Our Mission</a></li>
                        <li><a href="about/our-story.html">Our Story</a></li>
                        <li><a href="about/who-is-this-group-for.html">Who Is This Group For</a></li>
                        <li><a href="about/how-to-join.html">How To Join</a></li>
                    </ul>
                </li>
                
                <li class="nav-item dropdown">
                    <a href="what-we-do/24-6-support.html" class="nav-link">What we do?</a>
                    <ul class="dropdown-menu">
                        <li><a href="what-we-do/24-6-support.html">24/6 Support</a></li>
                        <li><a href="what-we-do/monthly-speakers.html">Monthly Speakers</a></li>
                        <li><a href="what-we-do/bags-for-bravery.html">Bags for Bravery (B4B)</a></li>
                        <li><a href="what-we-do/gatherings.html">Gatherings</a></li>
                        <li><a href="what-we-do/shabbatons.html">Shabbatons</a></li>
                    </ul>
                </li>
                
                <li class="nav-item dropdown">
                    <a href="additional-support/magnificent-me.html" class="nav-link">Additional Support</a>
                    <ul class="dropdown-menu">
                        <li><a href="additional-support/magnificent-me.html">Magnificent Me</a></li>
                    </ul>
                </li>
                
                <li class="nav-item">
                    <a href="contact.html" class="nav-link">Contact Us</a>
                </li>
                
                <li class="nav-item">
                    <a href="https://donorbox.org/wonder-women" target="_blank" class="nav-link donate-btn">Donate</a>
                </li>
            </ul>
            
            <div class="mobile-menu-toggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </nav>'

# New footer structure
NEW_FOOTER='    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-logo">
                    <img src="assets/images/ww-logo-white.png" alt="WonderWomen" class="footer-logo-img">
                </div>
                <h3 class="footer-heading">
                    <span class="footer-prefix">Feel free to send </span>
                    <span class="footer-highlight">us</span>
                    <span class="footer-postfix">an email</span>
                </h3>
                <div class="contact-buttons">
                    <a href="mailto:sashaparker@weareww.org" class="contact-btn">
                        <i class="fas fa-envelope"></i>
                        <span>Sasha Parker</span>
                    </a>
                    <a href="mailto:alizahamoyelle@weareww.org" class="contact-btn">
                        <i class="fas fa-envelope"></i>
                        <span>Alizah Amoyelle</span>
                    </a>
                </div>
                <div class="footer-copyright">
                    <p>Contents Copyright © 2025 Wonder Women Foundation Inc., a 501(c)3 charitable organization.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="assets/js/script.js"></script>'

# Function to update navigation in a file
update_navigation() {
    local file="$1"
    echo "Updating navigation in $file"
    
    # Create a temporary file
    temp_file=$(mktemp)
    
    # Replace the navigation section
    awk -v nav="$NEW_NAV" '
    BEGIN { in_nav = 0; nav_replaced = 0 }
    /<!-- Navigation -->/ { in_nav = 1; print nav; nav_replaced = 1; next }
    in_nav && /<\/nav>/ { in_nav = 0; next }
    in_nav { next }
    { print }
    ' "$file" > "$temp_file"
    
    # Replace the footer section
    awk -v footer="$NEW_FOOTER" '
    BEGIN { in_footer = 0; footer_replaced = 0 }
    /<!-- Footer -->/ { in_footer = 1; print footer; footer_replaced = 1; next }
    in_footer && /<\/body>/ { in_footer = 0; print; next }
    in_footer { next }
    { print }
    ' "$temp_file" > "$file"
    
    # Clean up
    rm "$temp_file"
}

# Update all HTML files
for file in about.html support.html services.html about/*.html what-we-do/*.html additional-support/*.html; do
    if [ -f "$file" ]; then
        update_navigation "$file"
    fi
done

echo "Navigation update complete!" 