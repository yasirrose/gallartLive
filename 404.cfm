<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfheader statuscode="404" statustext="Not Found">
<cfparam name="xss" default="">
<html lang="en">
	<head>
		<cfoutput>
			<title>Page Not Found (404) - #companyname#</title>
		</cfoutput>

		<cfinclude template="meta.cfm">
		<meta name="robots" content="noindex, follow">

		<cfoutput>
			<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
			<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
			<link rel="stylesheet" type="text/css" href="/stylesheet_.min.css">
			<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
			<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
			<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
			<script language="JavaScript" src="/js/utils.js"></script>
		</cfoutput>
	</head>

	<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<div class="main-container registration-page">
			<div id="Table_01">
				<div class="header-section">
					<div class="top-header">
						<cfinclude template="top_.cfm">
					</div>
					<div class="navbar-section">
						<cfinclude template="navbar_.cfm">
					</div>
				</div>
				<div class="inner-section">
					<div class="container-fluid">
						<div class="main-content">
							<div class="mobile-sidebar-logo">
								<div class="sidebar-Icon">
									<i class="fas fa-bars"></i>
								</div>
							</div>
							<div class="content-section" style="width: 100%;">
								<div class="bottom-content-sec">
									<div class="banner-section">
										<div class="art-work-content">
											<div aria-label="breadcrumb">
												<ol class="breadcrumb">
													<li class="breadcrumb-item"><a href="/" style="color:black;">Home</a></li>
													<li class="breadcrumb-item active" aria-current="page">404 Not Found</li>
												</ol>
											</div>

											<div class="bottom-content" style="padding: 50px 15px; text-align: center;">
												<h1 style="font-size: 72px; font-weight: 800; color: #222; margin-bottom: 8px; letter-spacing: -1px;">404</h1>
												<h2 style="font-size: 24px; font-weight: 700; color: #333; margin-bottom: 16px;">Artwork or Page Not Found</h2>
												<p style="font-size: 16px; color: #666; max-width: 600px; margin: 0 auto 30px auto; line-height: 1.6;">
													The artwork, artist collection, or page you are looking for is no longer available, may have been acquired, or the link has changed. You can explore our extensive inventory using the links below.
												</p>

												<div style="display: flex; gap: 12px; justify-content: center; flex-wrap: wrap; margin-bottom: 20px;">
													<a href="/" class="btn btn-dark" style="padding: 10px 24px; font-weight: 600; border-radius: 4px;">Return Home</a>
													<a href="/recent-acquisitions" class="btn btn-outline-dark" style="padding: 10px 24px; font-weight: 600; border-radius: 4px;">Recent Acquisitions</a>
													<a href="/artists" class="btn btn-outline-dark" style="padding: 10px 24px; font-weight: 600; border-radius: 4px;">Browse Artists</a>
													<a href="/contact.cfm" class="btn btn-outline-secondary" style="padding: 10px 24px; font-weight: 600; border-radius: 4px;">Contact Us</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<tr>
			<td colspan="2" valign="baseline">
				<cfinclude template="footer_.cfm">
			</td>
		</tr>
		<cfinclude template="frmxss.cfm">
	</body>
</html>
