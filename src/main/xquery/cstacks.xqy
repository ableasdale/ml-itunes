xquery version "1.0-ml";

import module namespace lib-view = "http://www.xmlmachines.com/ml-itunes/lib-view" at "lib/lib-view.xqy";


(: Module main :)
lib-view:create-cstack-page(
        "iTunes App",
        <div class="body-wrap">
            <div class="container">

                <h2>Here</h2>

                <ul class="menu clearfix gradient margin-100">
                    <li><a href="#"><span class="glyphicon glyphicon-home"></span></a></li>
                    <li><a href="#">Home</a></li>
                    <li class="hover"><a href="#">About</a>
                        <ul>
                            <li><a href="#">Web design</a></li>
                            <li><a href="#">User interface</a></li>
                            <li><a href="#">Social media</a>
                                <ul>
                                    <li><a href="#">Gallery images</a></li>
                                    <li><a href="#">OneByOne Slider</a></li>
                                    <li><a href="#">Audio Player</a></li>
                                    <li><a href="#">Video Player</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><a href="#">Contacts</a></li>
                </ul>





                <a href="#" class="btn btn-round"><span>Rounded</span></a>
                <div class="ribbon"><span>Default Ribbon</span></div>
                <a href="#" class="btn btn-left"><span>Prev</span></a>
                <a href="#" class="btn btn-right"><span>next</span></a>

                <div class="rating clearfix">
                    <span class="star on" rel="1">{" "}</span>
                    <span class="star on" rel="2">{" "}</span>
                    <span class="star on" rel="3">{" "}</span>
                    <span class="star off" rel="4">{" "}</span>
                    <span class="star off" rel="5">{" "}</span>
                </div>

                <hr/>
                <div class="input_styled checklist">
                    <div class="rowCheckbox switch">
                        <input name="signup2" type="checkbox" checked="checked" id="signup2" value="signup2"/>
                        <label for="signup2">Switch</label>
                    </div>
                </div>

                <hr />
                <div class="input_styled radiolist">
                    <div class="rowRadio">
                        <input type="radio" name="survey" value="radio1" checked="checked" id="radio1"/>
                        <label for="radio1">Checked</label>
                    </div>

                    <div class="rowRadio">
                        <input type="radio" name="survey" value="radio2" id="radio2"/>
                        <label for="radio2">Unchecked</label>
                    </div>
                </div>

                <div class="field_text">
                    <input type="text" name="name" id="name" placeholder="Name"/>
                </div>

                <div class="field_text omega">
                    <input type="text" name="email" id="email" placeholder="Email"/>
                </div>

                <div class="field_text field_textarea">
                    <textarea id="message" placeholder="Message">{" "}</textarea>
                </div>

                <hr/>
                <div class="widget-knob widget-volume">
                    <input type="text" value="100"  autocomplete="off" id="volume" />
                </div>
                <p>Todo - add js to enable ^</p>

                <hr/>
                <div class="tabs-framed">
                    <div class="inner">
                        <ul class="tabs clearfix">
                            <li class="active"><a href="#popular3" data-toggle="tab">Popular</a></li>
                            <li><a href="#recent3" data-toggle="tab">Recent</a></li>
                        </ul>

                        <div class="tab-content boxed">
                            <div class="tab-pane fade in active clearfix" id="popular3">
                                <h4>Young gypsy voice</h4>
                                <div class="tab-image pull-right"><img src="/assets/chubby-stacks/images/temp/tab-img-3.jpg" alt="" /></div>
                                <p>A cluster balloonist who became the first person to fly the English Channel has Intrepid Jonathan Trappe, 38, took off just like the 78-year-old character Carl Frederickson in the hit movie.</p>
                            </div>
                            <div class="tab-pane fade clearfix" id="recent3">
                                <h4>Young gypsy voice</h4>
                                <div class="tab-image"><img src="/assets/chubby-stacks/images/temp/tab-img-1.jpg" alt="" /></div>
                                <p>Intrepid Jonathan Trappe, 38, took off just like the 78-year-old character Carl Frederickson in the hit movie.</p>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="tabs-framed styled">
                    <div class="inner">
                        <ul class="tabs clearfix">
                            <li class="active"><a href="#events" data-toggle="tab">Events</a></li>
                            <li><a href="#reminder" data-toggle="tab"><sup class="note">3</sup>Reminder</a></li>
                            <li><a href="#starred" data-toggle="tab">Starred</a></li>
                            <li><a href="#archive" data-toggle="tab">Archive</a></li>
                        </ul>
                        <div class="tab-content boxed">
                            <div class="tab-pane fade in active clearfix" id="events">
                                <div class="tab-image pull-left"><img src="/assets/chubby-stacks/images/temp/tab-img-5.jpg" alt="" /></div>
                                <h4>4 august 2013</h4>
                                <p>He made his film debut with a minor part in Back to the Future</p>
                                <a href="#" class="see-more">See more</a>
                            </div>
                            <div class="tab-pane fade clearfix" id="reminder">
                                <div class="tab-image pull-right"><img src="/assets/chubby-stacks/images/temp/tab-img-6.jpg" alt="" /></div>
                                <h4>5 November</h4>
                                <p>He made his film debut with a minor part in Back to the Future</p>
                                <a href="#" class="see-more">See more</a>
                            </div>
                            <div class="tab-pane fade clearfix" id="starred">
                                <div class="tab-image pull-left"><img src="/assets/chubby-stacks/images/temp/tab-img-7.jpg" alt="" /></div>
                                <h4>11 October</h4>
                                <p>He made his film debut with a minor part in Back to the Future</p>
                                <a href="#" class="see-more">See more</a>
                            </div>
                            <div class="tab-pane fade clearfix" id="archive">
                                <div class="tab-image pull-right"><img src="/assets/chubby-stacks/images/temp/tab-img-8.jpg" alt="" /></div>
                                <h4>14 September</h4>
                                <p>He made his film debut with a minor part in Back to the Future</p>
                                <a href="#" class="see-more">See more</a>
                            </div>
                        </div>
                    </div>
                </div>
                <hr/>
                <div class="widget-container widget-search boxed styled">
                    <div class="inner">
                        <form method="get" id="searchform2" action="#">
                            <span class="btn btn-middle btn-caps">
                                <input type="submit" value="Search" />
                            </span>
                            <div class="field_text lightPlaceholder">
                                <input name="search2" value="" type="text" placeholder="Type word here" />
                            </div>
                        </form>
                    </div>
                </div>
                <hr/>
                <div class="comment-list message-field">
                    <ol>
                        <li class="comment">
                            <div class="comment-body">
                                <div class="comment-avatar">
                                    <div class="avatar">
                                        <img src="/assets/chubby-stacks/images/temp/avatar5.png" alt="" />
                                    </div>
                                </div>
                                <div class="comment-text">
                                    <div class="comment-author">
                                        <a href="#" class="link-author">Elijah Wood</a>
                                    </div>
                                    <div class="comment-entry">
                                        He made his film debut with a minor part in Back to the Future Part II (1989), then landed a succession. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ol>
                </div>
                <div class="widget-container widget-gallery boxed">
                    <div class="inner">
                        <div id="myCarousel3" class="carousel slide" data-interval="20000">

                            <div class="carousel-inner">
                                <div class="active item">
                                    <a href="#">
                                        <img src="/assets/chubby-stacks/images/temp/post-img-1.jpg" alt="" />
                                    </a>
                                    <div class="carousel-desc gradient">
                                        <strong>Brave</strong>
                                        <span>«Change your fate.»</span>
                                    </div>
                                </div>
                                <div class="item">
                                    <a href="#">
                                        <img src="/assets/chubby-stacks/images/temp/post-img-2.jpg" alt="" />
                                    </a>
                                    <div class="carousel-desc gradient">
                                        <strong>Ice Age</strong>
                                        <span>«Change your fate.»</span>
                                    </div>
                                </div>

                            </div>

                            <ol class="carousel-indicators">
                                <li data-target="#myCarousel3" data-slide-to="0" class="active"></li>
                                <li data-target="#myCarousel3" data-slide-to="1"></li>
                            </ol>

                            <a class="carousel-control left" href="#myCarousel3" data-slide="prev"></a>
                            <a class="carousel-control right" href="#myCarousel3" data-slide="next"></a>
                        </div>
                    </div>
                </div>
                <hr/>
                <div class="widget-container widget-profile boxed">
                    <div class="inner clearfix">
                        <div class="avatar">
                            <img src="/assets/chubby-stacks/images/temp/avatar.png" alt="" />
                        </div>
                        <h5>Bradley Cooper</h5>
                        <span class="subtitle">Сomedian actor</span>
                        <div class="follow">
                            <a href="#" class="btn btn-follow"><span>Follow</span></a>
                            <div class="followers">
                                <strong>1687</strong>
                                <span>followers</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
)